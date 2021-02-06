import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  final Map<String, dynamic> noteData;

  const NotePage({Key key, this.noteData}) : super(key: key);
  @override
  _NotePageState createState() => _NotePageState(noteData);
}

class _NotePageState extends State<NotePage> {
  final Map<String, dynamic> noteData;

  _NotePageState(this.noteData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(noteData['title']),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ListView(children: [Text("Ders Adı: ${noteData['lessonName']}")]),
      ),
    );
  }
}
