/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:notas_app/features/auth/data/datasources/repositories/auth_repository_impl.dart';
import 'package:notas_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:notas_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:notas_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:notas_app/features/auth/presentation/pages/home_page.dart';
import 'package:notas_app/features/auth/presentation/pages/login_page.dart';
import 'package:notas_app/features/notes/domain/repositories/notes_repository_impl.dart';
import 'package:notas_app/features/notes/presentation/bloc/note_event.dart';
import 'features/notes/data/datasources/notes_local_datasource.dart';
import 'features/notes/domain/repositories/notes_repository.dart';
import 'features/notes/domain/usecases/get_notes.dart' as usecase;
import 'features/notes/domain/usecases/add_note.dart' as usecase;
import 'features/notes/domain/usecases/update_note.dart' as usecase;
import 'features/notes/domain/usecases/delete_note.dart' as usecase;
import 'features/notes/presentation/bloc/note_bloc.dart';

void main() {
  final notesLocalDataSource = NotesLocalDataSource();
  final NotesRepository notesRepository = NotesRepositoryImpl(
    notesLocalDataSource,
  );

  runApp(MyApp(notesRepository: notesRepository));
}

class MyApp extends StatelessWidget {
  final NotesRepository notesRepository;

  const MyApp({super.key, required this.notesRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  AuthBloc(AuthRepositoryImpl(AuthLocalDataSource()))
                    ..add(AppStarted()),
        ),
        BlocProvider(
          create:
              (_) => NoteBloc(
                getNotes: usecase.GetNotes(notesRepository),
                addNote: usecase.AddNote(notesRepository),
                updateNote: usecase.UpdateNote(notesRepository),
                deleteNote: usecase.DeleteNote(notesRepository),
              )..add(LoadNotes()),
        ),
      ],
      child: MaterialApp(
        title: 'Notas App',
        routes: {
          '/login': (_) => const LoginPage(),
          '/home': (_) => const HomePage(),
        },
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
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
*/
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:notas_app/features/notes/presentation/pages/notes_list_page.dart';
import 'package:notas_app/features/notes/presentation/pages/note_form_page.dart';
import 'package:notas_app/features/auth/presentation/pages/login_page.dart';
import 'package:notas_app/features/auth/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notas App',
      routes: {
        '/login': (_) => const LoginPage(),
        '/home': (_) => const HomePage(),
        '/notes': (_) => const NotesListPage(),
        '/note-form': (_) => const NoteFormPage(isEditMode: false),
      },
      home: const HomePage(),
    );
  }
}
