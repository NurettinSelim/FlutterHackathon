import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:note_app/widgets/theme_helper.dart';
import 'wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Intl.defaultLocale = 'tr';
  await initializeDateFormatting('tr');

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.ralewayTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.grey),
        canvasColor: ThemeHelper.darkColor,
        primaryColor: ThemeHelper.darkColor,
        scaffoldBackgroundColor: ThemeHelper.darkColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: ThemeHelper.accentColor),
      ),
      themeMode: ThemeMode.light,
      title: 'Note App',
      home: FastNews(),
    );
  }
}

class FastNews extends StatefulWidget {
  @override
  _FastNewsState createState() => _FastNewsState();
}

class _FastNewsState extends State<FastNews> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () async {
      await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.stickyNote, size: 45),
          SizedBox(height: 10),
          Text(
            'Note App',
            style: GoogleFonts.raleway(fontSize: 45, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SpinKitThreeBounce(color: ThemeHelper.accentColor, size: 45),
        ],
      ),
    );
  }
}
