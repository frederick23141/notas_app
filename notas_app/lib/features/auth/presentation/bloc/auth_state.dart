import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

/// Clase base para los estados relacionados con la autenticación.
///
/// Esta clase define un estado genérico que extiende de [Equatable] para permitir
/// la comparación de los estados de autenticación de manera sencilla. Los estados
/// heredados de esta clase representan los diferentes estados que puede tener el
/// proceso de autenticación, como "cargando", "autenticado", "no autenticado" o "error".
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Estado inicial de la autenticación.
///
/// Este estado se emite cuando la aplicación se inicia o cuando no se ha realizado
/// ninguna acción relacionada con la autenticación aún.
class AuthInitial extends AuthState {}

/// Estado de carga de autenticación.
///
/// Este estado se emite cuando se está procesando una solicitud de autenticación, como
/// cuando el usuario está intentando iniciar sesión o verificar su estado de autenticación.
class AuthLoading extends AuthState {}

/// Estado cuando el usuario ha sido autenticado exitosamente.
///
/// Este estado se emite cuando el proceso de autenticación ha sido exitoso y el usuario
/// ha sido autenticado correctamente. Contiene una instancia de [UserEntity] con la
/// información del usuario autenticado.
class Authenticated extends AuthState {
  final UserEntity user;

  /// Constructor de la clase [Authenticated].
  ///
  /// Inicializa la instancia de [Authenticated] con la entidad [user] que contiene
  /// los detalles del usuario autenticado.
  ///
  /// Parámetro:
  /// - [user]: La entidad del usuario que ha sido autenticado.
  Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// Estado cuando el usuario no está autenticado.
///
/// Este estado se emite cuando el usuario no está autenticado, ya sea porque nunca
/// se autenticó o porque cerró sesión exitosamente.
class Unauthenticated extends AuthState {}

/// Estado de error en el proceso de autenticación.
///
/// Este estado se emite cuando ocurre un error durante el proceso de autenticación,
/// como un error en el inicio de sesión. Contiene un mensaje de error que describe
/// el problema.
class AuthError extends AuthState {
  final String message;

  /// Constructor de la clase [AuthError].
  ///
  /// Inicializa la instancia de [AuthError] con un mensaje que describe el error
  /// ocurrido durante el proceso de autenticación.
  ///
  /// Parámetro:
  /// - [message]: El mensaje de error que describe el problema de autenticación.
  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
