import 'package:equatable/equatable.dart';

/// Entidad que representa a un usuario.
///
/// Esta clase almacena los datos de un usuario, incluyendo su correo electrónico,
/// contraseña y token de autenticación. Extiende de [Equatable] para permitir la
/// comparación sencilla de objetos basados en sus propiedades.
class UserEntity extends Equatable {
  final String email;
  final String password;
  final String token;

  /// Constructor de la clase [UserEntity].
  ///
  /// Inicializa los valores de [email], [password] y [token] para crear una nueva
  /// instancia de usuario.
  ///
  /// Parámetros:
  /// - [email]: El correo electrónico del usuario.
  /// - [password]: La contraseña del usuario.
  /// - [token]: El token de autenticación del usuario.
  const UserEntity({
    required this.email,
    required this.password,
    required this.token,
  });

  /// Propiedades que se utilizarán para comparar dos objetos de [UserEntity].
  ///
  /// Esta implementación de [props] se utiliza para permitir que los objetos de
  /// [UserEntity] sean comparados mediante el paquete [Equatable]. Se devuelve
  /// una lista de todas las propiedades que deberían ser tenidas en cuenta al
  /// realizar una comparación de igualdad.
  ///
  /// Retorna:
  /// - Una lista de objetos ([email], [password], [token]) que se usan para
  ///   comparar instancias de [UserEntity].
  @override
  List<Object?> get props => [email, password, token];
}
