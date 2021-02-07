import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/services/image_to_text.dart';
import 'package:note_app/services/note_service.dart';
import 'package:note_app/widgets/const_vars.dart';
import 'package:note_app/widgets/theme_helper.dart';

import '../wrapper.dart';

class CreateNotePage extends StatefulWidget {
  final String imagePath;

  const CreateNotePage({Key key, this.imagePath}) : super(key: key);
  @override
  _CreateNotePageState createState() => _CreateNotePageState(imagePath);
}

class _CreateNotePageState extends State<CreateNotePage> {
  final String imagePath;
  final _imageToText = ImageToText();
  final _noteService = NoteService();
  final _imageTextController = TextEditingController();
  final _noteTitleController = TextEditingController();
  final _noteDetailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _lessonValue = Variables.lessonsList[0];

  _CreateNotePageState(this.imagePath);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 24),
                selectLesson,
                SizedBox(height: 16),
                TextFormField(
                  controller: _noteTitleController,
                  decoration: InputDecoration(
                    labelText: 'Not Başlığı',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                    errorStyle: TextStyle(color: ThemeHelper.accentColor),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: ThemeHelper.accentColor),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Not başlığı boş bırakılamaz.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _noteDetailController,
                  minLines: 3,
                  maxLines: 8,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Not Detayı',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                  ),
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 16),
                imageWithButton,
                SizedBox(height: 24),
                TextFormField(
                  maxLines: _imageTextController.text.split('\n').length,
                  controller: _imageTextController,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Görsel Metini',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: ThemeHelper.accentColor, minimumSize: Size(240, 40)),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _noteService.saveNote(
                        Note(
                          lessonName: _lessonValue,
                          title: _noteTitleController.text,
                          detail: _noteDetailController.text,
                          localImagePath: imagePath,
                          imageText: _imageTextController.text,
                          createdAt: Timestamp.now(),
                        ),
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wrapper()));
                    }
                  },
                  child: Text('Notu Kaydet'),
                ),
                SizedBox(height: 16),
              ],
            ),
          )
        ],
      ),
    );
  }

  Stack get imageWithButton => Stack(
        children: [
          Image.file(File(imagePath)),
          Positioned(
            bottom: 0,
            left: 8,
            child: MaterialButton(
              color: Colors.black.withOpacity(0.5),
              onPressed: () async {
                var imageText = await _imageToText.convert(imagePath);
                setState(() {
                  _imageTextController.text = imageText;
                });
              },
              child: Text(
                'Resimdeki Metni Yazıya Aktar',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ],
      );

  Row get selectLesson => Row(
        children: [
          Text(
            'Ders:',
            style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 18),
          ),
          SizedBox(width: 16),
          Expanded(
            child: DropdownButton(
              elevation: 8,
              isExpanded: true,
              items: [
                for (var lessonName in Variables.lessonsList)
                  DropdownMenuItem(
                    child: Text(lessonName),
                    value: lessonName,
                  )
              ],
              onChanged: (value) {
                setState(() {
                  _lessonValue = value;
                });
              },
              value: _lessonValue,
              hint: Text('Ders seçimi'),
            ),
          )
        ],
      );
}
