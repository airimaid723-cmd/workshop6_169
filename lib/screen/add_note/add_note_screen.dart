import 'package:flutter/material.dart';
import '../../models/note.dart';
import '../../repository/note_repository.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;
  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      _title.text = widget.note!.title;
      _description.text = widget.note!.description;
    }
    super.initState();
  }

  Future<void> _insertNote() async {
    final note = Note(
      title: _title.text,
      description: _description.text,
      createdAt: DateTime.now(),
    );
    await NoteRepository.insert(note: note);
    if (!mounted) return;
    Navigator.pop(context);
  }

  Future<void> _updateNote() async {
    final note = Note(
      id: widget.note!.id,
      title: _title.text,
      description: _description.text,
      createdAt: widget.note!.createdAt,
    );
    await NoteRepository.update(note: note);
    if (!mounted) return;
    Navigator.pop(context);
  }

  Future<void> _deleteNote() async {
    await NoteRepository.delete(note: widget.note!);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? "Add Note" : "Edit Note"),
        actions: [
          widget.note != null
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: const Text("คุณต้องการจะลบข้อมูลใช่หรือไม่"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _deleteNote();
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete_outline),
                )
              : const SizedBox(),
          IconButton(
            onPressed: widget.note == null ? _insertNote : _updateNote,
            icon: const Icon(Icons.done_outline_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: _title,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _description,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.note == null ? _insertNote : _updateNote,
              child: Text(widget.note == null ? 'Save' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}