import 'package:equatable/equatable.dart';

/// Clase base para los eventos relacionados con la autenticación.
///
/// Esta clase define un evento genérico que extiende de [Equatable] para permitir
/// la comparación de eventos de manera sencilla. Los eventos heredados de esta clase
/// representan diferentes acciones que el usuario puede realizar en relación con la
/// autenticación (como iniciar sesión, cerrar sesión o verificar el estado de la sesión).
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Evento que indica que la aplicación ha iniciado.
///
/// Este evento es utilizado para verificar el estado de autenticación del usuario
/// cuando la aplicación comienza. Dependiendo de este estado, se realizará el proceso
/// de autenticación o se determinará que el usuario no está autenticado.
class AppStarted extends AuthEvent {}

/// Evento que representa una solicitud de inicio de sesión.
///
/// Este evento se dispara cuando el usuario intenta iniciar sesión con su correo electrónico
/// y contraseña. La clase contiene los datos necesarios para realizar el inicio de sesión.
class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  /// Constructor de la clase [LoginRequested].
  ///
  /// Inicializa los valores de [email] y [password] con las credenciales proporcionadas
  /// por el usuario para autenticar su cuenta.
  ///
  /// Parámetros:
  /// - [email]: El correo electrónico del usuario para la autenticación.
  /// - [password]: La contraseña del usuario para la autenticación.
  LoginRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

/// Evento que representa una solicitud de cierre de sesión.
///
/// Este evento se dispara cuando el usuario solicita cerrar sesión. No necesita
/// parámetros, ya que solo se requiere la acción de eliminar las credenciales y
/// marcar al usuario como no autenticado.
class LogoutRequested extends AuthEvent {}
