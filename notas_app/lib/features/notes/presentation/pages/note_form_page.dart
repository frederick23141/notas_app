// lib/features/notes/presentation/pages/note_form_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_app/features/notes/presentation/bloc/note_bloc.dart';
import 'package:notas_app/features/notes/presentation/bloc/note_event.dart';
import 'package:notas_app/features/notes/domain/entities/note_entity.dart';

class NoteFormPage extends StatefulWidget {
  final bool isEditMode;
  final NoteEntity? note;

  const NoteFormPage({super.key, required this.isEditMode, this.note});

  @override
  _NoteFormPageState createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.isEditMode ? widget.note?.title : '',
    );
    _contentController = TextEditingController(
      text: widget.isEditMode ? widget.note?.content : '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditMode ? 'Editar Nota' : 'Crear Nota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Contenido'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese contenido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final note = NoteEntity(
                      id: widget.isEditMode ? widget.note?.id : null,
                      title: _titleController.text,
                      content: _contentController.text,
                    );
                    if (widget.isEditMode) {
                      context.read<NoteBloc>().add(UpdateNoteEvent(note));
                    } else {
                      context.read<NoteBloc>().add(AddNoteEvent(note));
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.isEditMode ? 'Actualizar' : 'Crear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
