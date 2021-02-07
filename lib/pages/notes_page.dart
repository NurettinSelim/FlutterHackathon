import 'package:flutter/material.dart';
import 'package:note_app/widgets/const_vars.dart';
import 'package:note_app/widgets/note_widgets.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Variables.lessonsList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notlar'),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            tabs: <Widget>[
              for (var lesson in Variables.lessonsList)
                Tab(
                  child: Text(
                    lesson,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            for (var lessonName in Variables.lessonsList) NoteView(lessonName: lessonName),
          ],
        ),
      ),
    );
  }
}
