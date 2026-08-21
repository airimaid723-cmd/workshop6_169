import 'package:flutter/material.dart';
import '../../repository/note_repository.dart';
import '../add_note/add_note_screen.dart';
import 'widgets/item_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text("My Diary"),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => setState(() {}),
          icon: const Icon(Icons.refresh),
        ), // IconButton
      ],
    ), // AppBar
      body: FutureBuilder(
        future: NoteRepository.getNote(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("Empty"),
              );
            }
            return ListView(
              padding: const EdgeInsets.all(15),
              children: [
                for (var note in snapshot.data!)
                  ItemNote(
                    note: note,
                  ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNoteScreen(),
            ),
          ).then((_) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}