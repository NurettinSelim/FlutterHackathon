import 'dart:io';

import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/services/auth.dart';
import 'package:note_app/widgets/theme_helper.dart';

import 'notes_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        print(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  AnimateIconController controller = AnimateIconController();
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Merhaba, DashDevs',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                Text('En Son Alınan Not'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
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
            child: Icon(FontAwesomeIcons.camera),
            label: 'Kameradan Not Çek',
            labelBackgroundColor: ThemeHelper.darkColor,
            onTap: () {
              getImage();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(authService.user.displayName ?? 'debug'),
              accountEmail: Text(authService.user.email ?? 'debug'),
            ),
            ListTile(
              title: Text(
                'Notlarım',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
