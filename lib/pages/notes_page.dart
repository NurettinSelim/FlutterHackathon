import 'package:flutter/material.dart';
import 'package:note_app/widgets/note_widgets.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> with SingleTickerProviderStateMixin {
  List<String> lessonsList = ['Edebiyat', 'Matematik', 'Coğrafya', 'Tarih', 'Fizik'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: lessonsList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notlar'),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            tabs: <Widget>[
              for (var lesson in lessonsList)
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
            for (var lesson in lessonsList) NoteView(lessonName: lesson),
          ],
        ),
      ),
    );
  }
}
