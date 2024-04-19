import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../models/note_provider.dart';

class AddToDo extends StatelessWidget {
  const AddToDo({super.key});

  @override
  Widget build(BuildContext context) {
    //TextFieldcontrollers
    TextEditingController titleController = TextEditingController();
    TextEditingController subTitleController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Notes
            const Text(
              "   Notes",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),

            //ToDo Input
            //The reason we use ListView & Expanded is b/c the input can be lenghty

            Expanded(
              child: ListView(
                children: [
                  //Title
                  TextField(
                    controller: titleController,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 25),
                      hintText: "Title",
                      hintStyle: TextStyle(fontSize: 24, color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 18),
                  //subtitle

                  TextField(
                    controller: subTitleController,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 30),
                      hintText: "Type something here",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            DateTime now = DateTime.now();
            String formattedDate = "${now.year} - ${now.month} - ${now.day}";
            Provider.of<NoteProvider>(context, listen: false).addToDo(Note(
                id: NoteProvider().todos.length,
                title: titleController.text,
                subtitle: subTitleController.text,
                isCompleted: false,
                editedDate: formattedDate));

            //close
            Navigator.pop(context);
          },
          elevation: 10,
          backgroundColor: Colors.amber,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.save,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
