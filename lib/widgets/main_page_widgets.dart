import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/pages/create_note_page.dart';
import 'package:note_app/pages/note_page.dart';
import 'package:note_app/services/note_service.dart';
import 'package:note_app/widgets/theme_helper.dart';

class FABSpeedDial extends StatelessWidget {
  final picker = ImagePicker();

  Future<void> getImage(context) async {
    ImageSource source;
    await showDialog(
      context: context,
      child: Dialog(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: Icon(FontAwesomeIcons.camera),
              title: Text('Kamera Kullanarak Resim Çek'),
              onTap: () {
                source = ImageSource.camera;
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.images),
              title: Text('Galeriden Resim Seç'),
              onTap: () {
                source = ImageSource.gallery;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );

    final pickedFile = await picker.getImage(source: source);

    if (pickedFile != null) {
      print(pickedFile.path);
      await Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNotePage(imagePath: pickedFile.path)));
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      overlayOpacity: 0.4,
      tooltip: 'Speed Dial',
      children: [
        SpeedDialChild(
          child: Icon(FontAwesomeIcons.edit),
          label: 'Yazıyla Not Ekle',
          labelBackgroundColor: ThemeHelper.darkColor,
          onTap: () {},
        ),
        SpeedDialChild(
          child: Icon(FontAwesomeIcons.image),
          label: 'Resimli Not Ekle',
          labelBackgroundColor: ThemeHelper.darkColor,
          onTap: () {
            getImage(context);
          },
        ),
      ],
    );
  }
}

class ExpandedNoteView extends StatelessWidget {
  final _noteService = NoteService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _noteService.lastItems,
      builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
        if (snapshot.hasData) {
          return Column(children: [
            for (var data in snapshot.data) ExpandedNoteTile(note: data),
          ]);
        }
        return Center(child: SpinKitFadingFour(color: ThemeHelper.accentColor, size: 65));
      },
    );
  }
}

class ExpandedNoteTile extends StatelessWidget {
  final Note note;

  const ExpandedNoteTile({Key key, this.note}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        note.title ?? '',
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                note.detail ?? '',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              SizedBox(height: 8),
              if (note.cloudImagePath != null)
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NotePage(note: note)));
                  },
                  child: Text('Detay Sayfasına Git'),
                )
            ],
          ),
        )
      ],
    );
  }
}
