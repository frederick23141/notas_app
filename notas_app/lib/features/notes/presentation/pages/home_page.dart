import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_app/core/constants/app_colors.dart';
import 'package:notas_app/core/constants/app_texts.dart';
import 'package:notas_app/core/routes/app_routes.dart';
import 'package:notas_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:notas_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:notas_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:notas_app/features/notes/presentation/pages/note_form_page.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';
import '../../domain/entities/note_entity.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Capturamos el estado de autenticación (AuthBloc)
    final authState = context.read<AuthBloc>().state;
    String? token;
    bool favorite = false;
    // Si el usuario está autenticado, se extrae el token
    if (authState is Authenticated) {
      token = authState.user.token;
      print("Token en HomePage (notas): $token");
    }
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        // Mostrar un indicador de carga mientras se cargan las notas
        if (state is NoteLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is NoteLoaded) {
          // Si las notas se cargan correctamente, se muestran en una lista
          final notes = state.notes;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                AppTexts.titlehome,
                style: TextStyle(fontSize: 30, color: AppColors.backgroundAlt),
              ),

              actions: [
                IconButton(
                  tooltip: token,
                  icon: const Icon(Icons.remove_red_eye, size: 30),
                  onPressed: () {
                    //mostrar token
                    mostarToken(context, token!);
                  },
                  color: AppColors.backgroundAlt,
                ),
                IconButton(
                  icon: const Icon(Icons.logout, size: 30),
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                    Navigator.pushNamed(context, AppRoutes.login);
                    //Navigator.pushReplacementNamed(context, '/login');
                  },
                  color: AppColors.backgroundAlt,
                ),
              ],
              backgroundColor: AppColors.buttonPrimary,
            ),
            body: SafeArea(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: IconButton(
                        icon: Icon(Icons.favorite_rounded),
                        color: AppColors.primary,
                        onPressed: () {
                          //agragar validacion de favorito o no
                          favorite = !favorite;
                        },
                      ),
                    ),
                    title: Text(note.title),
                    subtitle: Text(note.content),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Eliminar una nota
                        context.read<NoteBloc>().add(DeleteNote(note.id!));
                      },
                    ),
                    onTap: () {
                      // Navegar a la página de edición de notas
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => NoteFormPage(isEditMode: true, note: note),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Navegar a la página de creación de notas
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NoteFormPage(isEditMode: false),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        } else if (state is NoteError) {
          // Si hubo un error al cargar las notas
          return Scaffold(body: Center(child: Text(state.message)));
        } else {
          return const Scaffold(
            // En caso de que el estado de las notas no esté definido
            body: Center(child: Text(AppTexts.errorLoadNotesBody)),
          );
        }
      },
    );
  }

  /// Muestra un cuadro de diálogo con el token de autenticación.
  ///
  /// **Parámetros**:
  /// - `context`: El contexto en el cual se mostrará el cuadro de diálogo.
  /// - `token`: El token de autenticación que se capturo si ya hay inicio de session
  void mostarToken(BuildContext context, String token) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(AppTexts.titleToken),
          content: Row(children: [Text('${token}')]),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(AppTexts.btnTextCancel),
            ),
          ],
        );
      },
    );
  }
}
