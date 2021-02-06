import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register_page.dart';
import '../services/auth.dart';
import '../widgets/sign_in_button.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final mailController = TextEditingController();
  final passController = TextEditingController();

  bool _isVisible = true;

  void _toggle() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: mailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-Posta',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                    ),
                    validator: validateEmail,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passController,
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                      suffixIcon: IconButton(
                        icon: _isVisible ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                        onPressed: () => _toggle(),
                      ),
                    ),
                    obscureText: _isVisible,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            SignInButton(
              type: 'email',
              isRegister: false,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  var result = await _auth.signInWithEmail(mailController.text, passController.text);
                  if (result is FirebaseException) {
                    final snackBar = SnackBar(content: Text(result.message ?? 'Bilinmeyen bir hata oluştu.'));
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  }
                }
              },
            ),
            SizedBox(height: 6),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text('Kayıt olmak için tıkla!', style: Theme.of(context).textTheme.headline6),
            ),
            Divider(),
            Text('Diğer Seçenekler', style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 6),
            SignInButton(
              type: 'google',
              onPressed: () => _auth.signInGoogle(),
            ),
          ],
        ),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";

    var regex = RegExp(pattern);

    if (!regex.hasMatch(value) || value == null) {
      return 'Geçerli bir e-posta adresi giriniz';
    } else {
      return null;
    }
  }
}
