import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:notas_app/features/auth/presentation/bloc/auth_event.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';
import '../../domain/entities/note_entity.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is NoteLoaded) {
          print("Notas cargadas: ${state.notes.length}");
          final notes = state.notes;

          return Scaffold(
            appBar: AppBar(
              title: const Text("Notas"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.content),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<NoteBloc>().add(DeleteNote(note.id!));
                      },
                    ),
                    onTap: () {
                      // Agregar funcionalidad para editar nota
                    },
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _showAddNoteDialog(context);
              },
              child: const Icon(Icons.add),
            ),
          );
        } else if (state is NoteError) {
          return Scaffold(body: Center(child: Text(state.message)));
        } else {
          return const Scaffold(
            body: Center(child: Text('No se encontraron notas')),
          );
        }
      },
    );
  }

  // Método para mostrar un diálogo para agregar nota
  void _showAddNoteDialog(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Nota'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Contenido'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final note = NoteEntity(
                  title: titleController.text,
                  content: contentController.text,
                );
                context.read<NoteBloc>().add(AddNote(note));
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
