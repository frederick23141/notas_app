// lib/features/notes/presentation/pages/notes_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_app/core/constants/app_colors.dart';
import 'package:notas_app/core/constants/app_texts.dart';
import 'package:notas_app/features/notes/presentation/bloc/note_bloc.dart';
import 'package:notas_app/features/notes/presentation/bloc/note_state.dart';
import 'package:notas_app/features/notes/presentation/pages/note_form_page.dart';

class NotesListPage extends StatelessWidget {
  const NotesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.titlePage),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NoteFormPage(isEditMode: false),
                ),
              );
            },
          ),
        ],
      ),
      // Cuerpo de la pantalla que muestra el estado de las notas
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          // Si las notas están en proceso de carga, mostrar un indicador de progreso
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // Si las notas se han cargado correctamente, mostrar una lista de notas
          else if (state is NoteLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => NoteFormPage(isEditMode: true, note: note),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is NoteError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text(AppTexts.isNullNotes));
          }
        },
      ),
    );
  }
}
