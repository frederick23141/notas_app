import 'package:notas_app/core/utils/token_generator.dart';
import 'package:notas_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:notas_app/features/auth/domain/entities/user_entity.dart';
import 'package:notas_app/features/auth/domain/repositories/auth_repository.dart';

/// Implementación del repositorio de autenticación.
///
/// Esta clase proporciona la lógica para el manejo de las credenciales de
/// usuario, incluyendo el inicio y cierre de sesión, y la obtención de datos
/// del usuario. Utiliza el [AuthLocalDataSource] para almacenar y recuperar
/// la información de las credenciales localmente.
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  /// Constructor de la clase [AuthRepositoryImpl].
  ///
  /// Recibe una instancia de [AuthLocalDataSource] que se utilizará para
  /// almacenar y recuperar las credenciales.
  AuthRepositoryImpl(this.localDataSource);

  /// Inicia sesión con las credenciales proporcionadas y genera un token.
  ///
  /// Este método genera un token aleatorio de 24 caracteres y guarda el correo
  /// electrónico, la contraseña y el token en el almacenamiento local.
  ///
  /// Parámetros:
  /// - [email]: El correo electrónico del usuario.
  /// - [password]: La contraseña del usuario.
  ///
  /// Retorna:
  /// - Un [Future<void>] que indica que la operación es asincrónica.
  @override
  Future<void> login(String email, String password) async {
    final token = TokenGenerator.generateToken(24);
    await localDataSource.saveCredentials(email, password, token);
  }

  /// Cierra la sesión del usuario.
  ///
  /// Este método elimina las credenciales guardadas en el almacenamiento local.
  ///
  /// Retorna:
  /// - Un [Future<void>] que indica que la operación es asincrónica.
  @override
  Future<void> logout() async {
    await localDataSource.clearCredentials();
  }

  /// Verifica si el usuario está logueado.
  ///
  /// Este método consulta el almacenamiento local para verificar si existen
  /// credenciales guardadas.
  ///
  /// Retorna:
  /// - Un [Future<bool>] que indica si el usuario está logueado o no.
  @override
  Future<bool> isLoggedIn() async {
    final creds = await localDataSource.getCredentials();
    return creds != null;
  }

  /// Obtiene la información del usuario logueado.
  ///
  /// Este método recupera las credenciales del usuario desde el almacenamiento
  /// local y devuelve un objeto [UserEntity] con los datos del usuario.
  ///
  /// Retorna:
  /// - Un [Future<UserEntity?>] que contiene la información del usuario si
  ///   está logueado, o `null` si no hay credenciales guardadas.
  @override
  Future<UserEntity?> getUser() async {
    final creds = await localDataSource.getCredentials();
    if (creds != null) {
      return UserEntity(
        email: creds['email']!,
        password: creds['password']!,
        token: creds['token']!,
      );
    }
    return null;
  }
}
