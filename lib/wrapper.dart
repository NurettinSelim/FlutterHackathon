import 'package:flutter/material.dart';
import 'pages/main_page.dart';
import 'pages/sign_in_page.dart';
import 'services/auth.dart';

class Wrapper extends StatelessWidget {
  final Stream _user = AuthService().userStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _user,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return SignInPage();
        } else {
          return MainPage();
        }
      },
    );
  }
}
