// lib/features/notes/presentation/pages/note_form_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_app/core/constants/app_colors.dart';
import 'package:notas_app/core/constants/app_texts.dart';
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
        backgroundColor: AppColors.primary,
        title: Text(
          widget.isEditMode
              ? AppTexts.titleUpdateNote
              : AppTexts.titleCreateNote,
          style: TextStyle(color: AppColors.backgroundAlt, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //mostar fecha
              Row(
                children: [
                  Text(
                    widget.isEditMode
                        ? ' ${AppTexts.dateUpdateText} :${widget.note?.dateupdate}'
                        : '${AppTexts.dateCreateText} : ${DateTime.now().toIso8601String()}',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: AppTexts.fieldTitleText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppTexts.fieldNullTitleText;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: AppTexts.fliedContenText,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppTexts.fieldNullContentText;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final note = NoteEntity(
                        id: widget.isEditMode ? widget.note?.id : null,
                        title: _titleController.text,
                        content: _contentController.text,
                        date: DateTime.now(),
                      );
                      if (widget.isEditMode) {
                        //context.read<NoteBloc>().add(UpdateNote(note));
                        setState(() {
                          context.read<NoteBloc>().add(UpdateNote(note));
                        });
                      } else {
                        setState(() {
                          context.read<NoteBloc>().add(AddNote(note));
                        });
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    widget.isEditMode
                        ? AppTexts.btnUpdateText
                        : AppTexts.btnCreateText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
