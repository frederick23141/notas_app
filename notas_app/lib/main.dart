import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_app/features/auth/data/datasources/repositories/auth_repository_impl.dart';
import 'package:notas_app/features/auth/presentation/bloc/auth_state.dart';
import 'features/auth/data/datasources/auth_local_datasource.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/home_page.dart';

void main() {
  final localDataSource = AuthLocalDataSource();
  final AuthRepository repository = AuthRepositoryImpl(localDataSource);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final AuthRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(repository)..add(AppStarted()),
      child: MaterialApp(
        title: 'Notas App',
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (_) => const LoginPage(),
          '/home': (_) => const HomePage(),
        },
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return const HomePage();
            } else if (state is Unauthenticated) {
              return const LoginPage();
            } else {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}
