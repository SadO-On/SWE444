import 'package:firebase_auth/firebase_auth.dart';
import 'userc.dart';

class AuthService {
  bool isLogOut = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _useFromFireFireBaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

//auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_useFromFireFireBaseUser);
  }

//sign in anony
  Future signInAnony() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _useFromFireFireBaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

//sign in whit email-pass

  Future signInEAndP(String e, String p) async {
    try {
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: e, password: p);
      FirebaseUser user = result.user;
      return _useFromFireFireBaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

//sign up
  Future signUpEAndP(String e, String p) async {
    try {
      AuthResult result =
          await _auth.createUserWithEmailAndPassword(email: e, password: p);
      FirebaseUser user = result.user;
      //Create new document for user with UesrID
      // await DataBaseService(userId: user.uid)
      //     .updateUserAd('title', 0, 'description');
      return _useFromFireFireBaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

//sign out whith
  Future signOut() async {
    try {
      var x = await _auth.signOut();
      isLogOut = true;
      return x;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
