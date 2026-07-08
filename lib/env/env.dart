import 'package:envied/envied.dart';

part 'env.g.dart';

/// Carga las variables de entorno desde el archivo `.env` en tiempo de compilación.
///
/// Los valores nunca se escriben en el código fuente: `envied` los inyecta
/// (ofuscados) en el archivo generado `env.g.dart`.
@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'SUPABASE_URL')
  static final String supabaseUrl = _Env.supabaseUrl;

  @EnviedField(varName: 'SUPABASE_ANON_KEY')
  static final String supabaseAnonKey = _Env.supabaseAnonKey;

  @EnviedField(varName: 'FCM_SENDER_ID', defaultValue: '')
  static final String fcmSenderId = _Env.fcmSenderId;
}
