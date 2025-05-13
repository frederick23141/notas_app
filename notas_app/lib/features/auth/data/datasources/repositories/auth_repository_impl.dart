import 'package:notas_app/core/utils/token_generator.dart';
import 'package:notas_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:notas_app/features/auth/domain/entities/user_entity.dart';
import 'package:notas_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<void> login(String email, String password) async {
    final token = TokenGenerator.generateToken(24);
    await localDataSource.saveCredentials(email, password, token);
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearCredentials();
  }

  @override
  Future<bool> isLoggedIn() async {
    final creds = await localDataSource.getCredentials();
    return creds != null;
  }

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
