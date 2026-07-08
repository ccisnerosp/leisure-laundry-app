import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/ciclo.dart';
import '../../domain/entities/cliente.dart';
import '../../domain/entities/programa.dart';
import 'core_providers.dart';
import 'usecase_providers.dart';

/// Estado de la UI del ciclo activo (OM-01).
sealed class CicloUiState {
  const CicloUiState();
}

class CicloInactivo extends CicloUiState {
  const CicloInactivo();
}

class CicloIniciando extends CicloUiState {
  const CicloIniciando();
}

/// Ciclo en curso con el tiempo restante actualizado cada segundo.
class CicloCorriendo extends CicloUiState {
  final Ciclo ciclo;
  final Duration restante;
  const CicloCorriendo(this.ciclo, this.restante);
}

/// El temporizador llegó a cero; espera la confirmación de retiro (HU-02.3).
class CicloFinalizado extends CicloUiState {
  final Ciclo ciclo;
  const CicloFinalizado(this.ciclo);
}

class CicloErrorState extends CicloUiState {
  final Failure failure;
  const CicloErrorState(this.failure);
}

/// Controla el ciclo de vida del temporizador. El tiempo restante se calcula
/// siempre a partir de `inicio_en` + duración (timestamps absolutos), por lo que
/// el conteo es preciso aunque la app pase a segundo plano o se reabra
/// (HU-02.2: desviación máxima ±2 s; el temporizador sobrevive al background).
class CicloController extends StateNotifier<CicloUiState> {
  final Ref _ref;
  Timer? _timer;

  CicloController(this._ref) : super(const CicloInactivo());

  int _notifId(Ciclo c) => c.id.hashCode & 0x7fffffff;

  /// Reanuda un ciclo en curso al abrir la pantalla del operario.
  Future<void> reanudar(String usuarioId) async {
    final res =
        await _ref.read(obtenerCicloEnCursoUseCaseProvider).call(usuarioId);
    res.fold(
      (f) => state = const CicloInactivo(),
      (ciclo) {
        if (ciclo == null) {
          state = const CicloInactivo();
        } else {
          _engancharTemporizador(ciclo);
        }
      },
    );
  }

  /// HU-02.2 · Inicia un ciclo y activa el temporizador.
  Future<void> iniciar({
    required String usuarioId,
    required Programa programa,
    required Cliente cliente,
  }) async {
    state = const CicloIniciando();
    final res = await _ref.read(iniciarCicloUseCaseProvider).call(
          usuarioId: usuarioId,
          programa: programa,
          cliente: cliente,
        );
    await res.fold(
      (f) async => state = CicloErrorState(f),
      (ciclo) async {
        // Programa la notificación de fin (suena aunque esté en background).
        await _ref.read(notificationServiceProvider).programarFinCiclo(
              id: _notifId(ciclo),
              programa: ciclo.programaNombre ?? programa.nombre,
              cliente: ciclo.clienteNombre ?? cliente.nombre,
              finProgramado: ciclo.finProgramado,
            );
        _engancharTemporizador(ciclo);
      },
    );
  }

  /// HU-02.4 · Confirma el retiro de prendas y cierra el ciclo.
  Future<Failure?> confirmarRetiro() async {
    final actual = state;
    final ciclo = switch (actual) {
      CicloFinalizado(ciclo: final c) => c,
      CicloCorriendo(ciclo: final c) => c,
      _ => null,
    };
    if (ciclo == null) return null;

    await _ref.read(alarmaServiceProvider).detener();
    await _ref.read(notificationServiceProvider).cancelar(_notifId(ciclo));

    final res = await _ref.read(cerrarCicloUseCaseProvider).call(ciclo.id);
    return res.fold(
      (f) {
        state = CicloErrorState(f);
        return f;
      },
      (_) {
        _detenerTimer();
        state = const CicloInactivo();
        return null;
      },
    );
  }

  void _engancharTemporizador(Ciclo ciclo) {
    _detenerTimer();
    void actualizar() {
      final restante = ciclo.tiempoRestante(DateTime.now());
      if (restante <= Duration.zero) {
        _detenerTimer();
        _dispararFin(ciclo);
      } else {
        state = CicloCorriendo(ciclo, restante);
      }
    }

    actualizar();
    if (state is CicloCorriendo) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => actualizar());
    }
  }

  Future<void> _dispararFin(Ciclo ciclo) async {
    state = CicloFinalizado(ciclo);
    // Refuerza la alerta sonora/visual en primer plano (HU-02.3).
    await _ref.read(alarmaServiceProvider).iniciar();
    await _ref.read(notificationServiceProvider).mostrarFinCicloAhora(
          id: _notifId(ciclo),
          programa: ciclo.programaNombre ?? '',
          cliente: ciclo.clienteNombre ?? '',
        );
  }

  void _detenerTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _detenerTimer();
    super.dispose();
  }
}

final cicloControllerProvider =
    StateNotifierProvider<CicloController, CicloUiState>((ref) {
  return CicloController(ref);
});

/// Historial de ciclos del usuario (HU-02.4).
final ciclosUsuarioProvider =
    FutureProvider.autoDispose.family<List<Ciclo>, String>((ref, usuarioId) async {
  final res = await ref.read(listarCiclosUseCaseProvider).call(usuarioId);
  return res.fold((f) => throw f, (data) => data);
});
