import 'package:flutter/material.dart';
import 'package:note_app/screen/note_view.dart';

class NavigatorFunction {
  static void navigator(context, name) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NoteView()));
  }
}
