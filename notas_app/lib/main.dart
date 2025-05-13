import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notas_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:notas_app/features/auth/data/datasources/repositories/auth_repository_impl.dart';
import 'package:notas_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:notas_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:notas_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:notas_app/features/auth/presentation/pages/login_page.dart';

//import 'package:notas_app/features/auth/presentation/pages/home_page.dart';
import 'package:notas_app/features/notes/presentation/pages/home_page.dart';

import 'package:notas_app/features/notes/domain/repositories/notes_repository_impl.dart';
import 'package:notas_app/features/notes/presentation/bloc/note_bloc.dart';
import 'package:notas_app/features/notes/presentation/bloc/note_event.dart';
import 'package:notas_app/features/notes/presentation/pages/note_form_page.dart';
import 'package:notas_app/features/notes/presentation/pages/notes_list_page.dart';
import 'features/notes/data/datasources/notes_local_datasource.dart';

import 'features/notes/domain/usecases/get_notes.dart' as usecase;
import 'features/notes/domain/usecases/add_note.dart' as usecase;
import 'features/notes/domain/usecases/update_note.dart' as usecase;
import 'features/notes/domain/usecases/delete_note.dart' as usecase;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = AuthBloc(AuthRepositoryImpl(AuthLocalDataSource()))
      ..add(AppStarted());

    final notesLocalDataSource = NotesLocalDataSource();
    final notesRepository = NotesRepositoryImpl(notesLocalDataSource);
    final noteBloc = NoteBloc(
      getNotes: usecase.GetNotes(notesRepository),
      addNote: usecase.AddNote(notesRepository),
      updateNote: usecase.UpdateNote(notesRepository),
      deleteNote: usecase.DeleteNote(notesRepository),
    )..add(LoadNotes());

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: authBloc),
        BlocProvider<NoteBloc>.value(value: noteBloc),
      ],
      child: MaterialApp(
        title: 'Notas App',
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (_) => const LoginPage(),
          '/home': (_) => const HomePage(),
          '/notes': (_) => const NotesListPage(),
          '/note-form': (_) => const NoteFormPage(isEditMode: false),
        },
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state is Authenticated) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
