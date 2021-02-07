import 'package:animate_icons/animate_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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
        // title: Text('Merhaba, DashDevs', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AutoSizeText(
                    // "${authService.user.displayName} Note App'e hoşgeldin :)",
                    "Note App'e hoşgeldin :)",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                    maxLines: 1,
                  ),
                  SizedBox(height: 10),
                  AutoSizeText(
                    'Kenardaki menüden tüm notlarına ulaşabilirsin!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                    maxLines: 1,
                  ),
                  SizedBox(height: 10),
                  AutoSizeText(
                    'Aşağıdan ise son aldığın notlara ulaşabilirsin!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'En Son Alınan Notlar:',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  ExpandedNoteView(),
                ],
              ),
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
