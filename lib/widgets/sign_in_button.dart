import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInButton extends StatelessWidget {
  final String type;
  final Function onPressed;
  final bool isRegister;

  const SignInButton({Key key, this.type, this.onPressed, this.isRegister}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset('assets/$type.svg', height: 28),
          SizedBox(width: 24),
          Text(buttonText, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  String get buttonText {
    switch (type) {
      case 'email':
        return isRegister ? 'E-Posta ile kayıt ol' : 'E-Posta ile giriş yap';
        break;
      case 'google':
        return 'Google ile giriş yap';
        break;
      case 'apple':
        return 'Apple ile giriş yap';
        break;
      default:
        return '';
    }
  }
}
