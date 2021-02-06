import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //auth change user stream
  Stream<User> get userStream => _auth.authStateChanges();

  User get user => _auth.currentUser;

  Future signOrRegister(email, pass) async {
    ///
    /// If email doesn't exists, creates an account
    ///
    try {
      var result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return result;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        try {
          var result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
          return result;
        } on FirebaseAuthException catch (e) {
          return e;
        }
      }
      return e;
    }
  }

  Future registerWithEmail(email, pass) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      return result;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return e;
    }
  }

  Future signInWithEmail(email, pass) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return result;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return e;
    }
  }

  //email pass
  Future signInGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      var result = await _auth.signInWithCredential(credential);
      return result.user;
    } on FirebaseAuthException catch (e) {
      print(e);
      return e;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
