import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:note_app/pages/create_note_page.dart';
import 'package:note_app/services/auth.dart';
import 'package:note_app/widgets/main_page_widgets.dart';
import 'package:note_app/widgets/theme_helper.dart';

import 'notes_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AnimateIconController controller = AnimateIconController();
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Merhaba, DashDevs', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                Text('En Son Alınan Not'),
                RaisedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNotePage()));
                })
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FABSpeedDial(),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(authService.user.displayName ?? ''),
              accountEmail: Text(authService.user.email ?? ''),
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
            Spacer(),
            TextButton.icon(
              onPressed: () {
                authService.signOut();
              },
              icon: Icon(Icons.logout, color: ThemeHelper.accentColor),
              label: Text('Çıkış Yap', style: Theme.of(context).textTheme.headline6),
            )
          ],
        ),
      ),
    );
  }
}
