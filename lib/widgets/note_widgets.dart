import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/pages/note_page.dart';
import 'package:note_app/services/note_service.dart';
import 'package:note_app/widgets/theme_helper.dart';

class NoteView extends StatefulWidget {
  final String lessonName;

  const NoteView({Key key, this.lessonName}) : super(key: key);
  @override
  _NoteViewState createState() => _NoteViewState(lessonName);
}

class _NoteViewState extends State<NoteView> {
  final String lessonName;
  final _noteService = NoteService();

  _NoteViewState(this.lessonName);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _noteService.getNotesFromLesson(lessonName),
      builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            itemBuilder: (ctxt, index) {
              return NoteTile(noteData: snapshot.data[index]);
            },
            itemCount: snapshot.data.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
          );
        }
        return Center(child: SpinKitFadingFour(color: ThemeHelper.accentColor, size: 65));
      },
    );
  }
}

class NoteTile extends StatelessWidget {
  final Note noteData;

  const NoteTile({Key key, this.noteData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(Icons.arrow_forward_ios),
      title: Text(
        noteData.title ?? '',
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
      ),
      subtitle: Text(noteData.detail ?? ''),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NotePage(note: noteData)));
      },
    );
  }
}
