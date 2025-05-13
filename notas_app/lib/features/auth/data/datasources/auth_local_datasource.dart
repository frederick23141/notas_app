import 'package:shared_preferences/shared_preferences.dart';

/// Fuente de datos local para el almacenamiento de credenciales de usuario.
///
/// Esta clase utiliza la biblioteca [SharedPreferences] para guardar, recuperar
/// y borrar las credenciales del usuario (correo electrónico, contraseña y token)
/// de manera persistente en el almacenamiento local del dispositivo.
class AuthLocalDataSource {
  /// Guarda las credenciales del usuario en el almacenamiento local.
  ///
  /// Este método almacena el correo electrónico, la contraseña y el token
  /// proporcionados utilizando [SharedPreferences].
  ///
  /// Parámetros:
  /// - [email]: El correo electrónico del usuario.
  /// - [password]: La contraseña del usuario.
  /// - [token]: El token de autenticación del usuario.
  ///
  /// Retorna:
  /// - Un [Future<void>] que indica que la operación es asincrónica.
  Future<void> saveCredentials(
    String email,
    String password,
    String token,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('token', token);
  }

  /// Recupera las credenciales del usuario desde el almacenamiento local.
  ///
  /// Este método obtiene el correo electrónico, la contraseña y el token
  /// guardados previamente utilizando [SharedPreferences].
  ///
  /// Retorna:
  /// - Un [Future<Map<String, String>?] que contiene las credenciales
  ///   del usuario si están disponibles, o `null` si no hay credenciales
  ///   almacenadas.
  Future<Map<String, String>?> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    final token = prefs.getString('token');

    if (email != null && password != null && token != null) {
      return {'email': email, 'password': password, 'token': token};
    }
    return null;
  }

  /// Elimina las credenciales del usuario del almacenamiento local.
  ///
  /// Este método borra todas las credenciales almacenadas utilizando
  /// [SharedPreferences], dejando el almacenamiento local limpio.
  ///
  /// Retorna:
  /// - Un [Future<void>] que indica que la operación es asincrónica.
  Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
