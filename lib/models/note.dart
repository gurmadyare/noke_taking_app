import 'package:flutter/material.dart';

class Note {
  int? id;
  String? title;
  String? subtitle;
  bool? isCompleted;
  String? editedDate;

  Note(
      {@required this.id,
      @required this.title,
      @required this.subtitle,
      @required this.isCompleted,
      @required this.editedDate});
}
