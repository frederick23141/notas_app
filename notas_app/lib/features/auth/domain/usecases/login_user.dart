import '../repositories/auth_repository.dart';

/// Clase que representa el caso de uso para iniciar sesión de un usuario.
///
/// Esta clase define la lógica de negocio relacionada con el inicio de sesión de
/// un usuario, utilizando el repositorio de autenticación. El propósito de esta
/// clase es actuar como una capa entre la interfaz de usuario y el repositorio,
/// encapsulando la lógica de inicio de sesión.
class LoginUser {
  final AuthRepository repository;

  /// Constructor de la clase [LoginUser].
  ///
  /// Recibe una instancia de [AuthRepository] que se utiliza para interactuar
  /// con el almacenamiento de datos relacionado con la autenticación del usuario.
  ///
  /// Parámetro:
  /// - [repository]: El repositorio de autenticación que manejará la lógica
  ///   del inicio de sesión.
  LoginUser(this.repository);

  /// Realiza el proceso de inicio de sesión con las credenciales proporcionadas.
  ///
  /// Este método utiliza el repositorio de autenticación para autenticar al usuario
  /// mediante su correo electrónico y contraseña. Al ser asincrónico, se espera
  /// que la operación se complete antes de proceder.
  ///
  /// Parámetros:
  /// - [email]: El correo electrónico del usuario que desea iniciar sesión.
  /// - [password]: La contraseña del usuario para autenticar su cuenta.
  ///
  /// Retorna:
  /// - Un [Future<void>] que indica que la operación es asincrónica y no retorna
  ///   un valor específico, solo indica el éxito o fracaso del inicio de sesión.
  Future<void> call(String email, String password) async {
    return repository.login(email, password);
  }
}
