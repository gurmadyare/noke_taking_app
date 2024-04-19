import 'package:flutter/material.dart';
import 'package:note_taking/models/note.dart';

class NoteProvider extends ChangeNotifier {
  final List<Note> _todos = [];

  List<Note> get todos => _todos;

  //Add
  void addToDo(Note todo) {
    _todos.add(todo);

    notifyListeners();
  }

  //Remove
  void removeToDo(int index) {
    todos.removeAt(index);

    notifyListeners();
  }

  //completed
  void isCompleted(int index) {
    todos[index].isCompleted = !todos[index].isCompleted!;

    notifyListeners();
  }
}
