import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/services/note_service.dart';
import 'package:note_app/widgets/theme_helper.dart';

import '../wrapper.dart';

class NotePage extends StatefulWidget {
  final Note note;

  const NotePage({Key key, this.note}) : super(key: key);
  @override
  _NotePageState createState() => _NotePageState(note);
}

class _NotePageState extends State<NotePage> {
  final _noteService = NoteService();
  final Note note;
  bool isGrey = true;

  _NotePageState(this.note);
  @override
  Widget build(BuildContext context) {
    if (note.imagePath == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(note.title),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListView(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Not Açıklaması:', style: TextStyle(fontSize: 22, decoration: TextDecoration.underline)),
                      SizedBox(height: 6),
                      Text('${note.detail}', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              _noteService.deleteNote(note.id);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wrapper()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Not Açıklaması:', style: TextStyle(fontSize: 22, decoration: TextDecoration.underline)),
                    SizedBox(height: 6),
                    Text('${note.detail}', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isGrey = !isGrey;
                    });
                  },
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          if (isGrey) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent],
                            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                          } else {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white, Colors.white],
                            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                          }
                        },
                        blendMode: BlendMode.dstIn,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: note.cloudImagePath,
                            placeholder: (context, url) => Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(child: SpinKitFadingFour(color: ThemeHelper.accentColor, size: 65)),
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                      if (isGrey)
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              '${note.imageText}',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
