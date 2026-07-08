import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Almacena la sesión de Supabase Auth en el almacenamiento seguro del SO
/// (Keychain en iOS, EncryptedSharedPreferences en Android), cumpliendo
/// RNF-13/RNF-14 (HU-01.3). Reemplaza el storage por defecto de Supabase.
class SecureLocalStorage extends LocalStorage {
  static const _key = 'leisure_supabase_session';

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  @override
  Future<void> initialize() async {}

  @override
  Future<String?> accessToken() => _storage.read(key: _key);

  @override
  Future<bool> hasAccessToken() => _storage.containsKey(key: _key);

  @override
  Future<void> persistSession(String persistSessionString) =>
      _storage.write(key: _key, value: persistSessionString);

  @override
  Future<void> removePersistedSession() => _storage.delete(key: _key);
}
