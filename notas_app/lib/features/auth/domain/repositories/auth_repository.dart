import '../entities/user_entity.dart';

/// Repositorio abstracto para la autenticación del usuario.
///
/// Esta clase define los métodos básicos para gestionar el estado de autenticación no podemos acceder directamente a la clase debemos realizar un implement
/// del usuario, incluyendo el inicio y cierre de sesión, la verificación del estado
/// de autenticación y la obtención de los datos del usuario. Debe ser implementada
/// por una clase concreta que proporcione la lógica para acceder a la fuente de datos.
abstract class AuthRepository {
  /// Inicia sesión con las credenciales proporcionadas.
  ///
  /// Este método permite autenticar al usuario con su correo electrónico y
  /// contraseña. Al realizar el login, se deberían almacenar las credenciales
  /// y otros datos necesarios (como un token de sesión).
  ///
  /// Parámetros:
  /// - [email]: El correo electrónico del usuario.
  /// - [password]: La contraseña del usuario.
  ///
  /// Retorna:
  /// - Un [Future<void>] que indica que la operación es asincrónica.
  Future<void> login(String email, String password);

  /// Cierra sesión del usuario.
  ///
  /// Este método permite cerrar sesión y eliminar las credenciales almacenadas.
  ///
  /// Retorna:
  /// - Un [Future<void>] que indica que la operación es asincrónica.
  Future<void> logout();

  /// Verifica si el usuario está logueado.
  ///
  /// Este método debe verificar si existen credenciales válidas almacenadas
  /// para determinar si el usuario está autenticado.
  ///
  /// Retorna:
  /// - Un [Future<bool>] que indica si el usuario está logueado o no.
  Future<bool> isLoggedIn();

  /// Obtiene los datos del usuario logueado.
  ///
  /// Este método recupera los datos del usuario (como el correo electrónico,
  /// la contraseña y el token) si el usuario está autenticado.
  ///
  /// Retorna:
  /// - Un [Future<UserEntity?>] que contiene un objeto [UserEntity] con los
  ///   datos del usuario si está logueado, o `null` si no hay un usuario autenticado.
  Future<UserEntity?> getUser();
}
