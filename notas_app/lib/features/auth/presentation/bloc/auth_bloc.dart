import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// Bloc encargado de manejar los eventos y estados relacionados con la autenticación.
///
/// Esta clase es responsable de gestionar los eventos relacionados con el estado de autenticación
/// del usuario (inicio de sesión, cierre de sesión y verificación del estado de autenticación).
/// Utiliza el patrón BLoC (Business Logic Component) para separar la lógica de negocio de la interfaz.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  /// Constructor de la clase [AuthBloc].
  ///
  /// Recibe una instancia de [AuthRepository] que se utilizará para interactuar
  /// con el almacenamiento de datos relacionado con la autenticación del usuario.
  ///
  /// Parámetro:
  /// - [repository]: El repositorio de autenticación que manejará las operaciones
  ///   relacionadas con el inicio de sesión y la gestión del usuario.
  AuthBloc(this.repository) : super(AuthInitial()) {
    // Maneja el evento cuando la aplicación comienza.
    on<AppStarted>((event, emit) async {
      emit(AuthLoading());
      final isLogged = await repository.isLoggedIn();
      if (isLogged) {
        final user = await repository.getUser();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(Unauthenticated());
        }
      } else {
        emit(Unauthenticated());
      }
    });

    // Maneja el evento cuando se solicita iniciar sesión.
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await repository.login(event.email, event.password);
        final user = await repository.getUser();
        emit(Authenticated(user!));
      } catch (e) {
        emit(AuthError("Error al iniciar sesión"));
      }
    });

    // Maneja el evento cuando se solicita cerrar sesión.
    on<LogoutRequested>((event, emit) async {
      await repository.logout();
      emit(Unauthenticated());
    });
  }
}
