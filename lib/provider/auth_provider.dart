import 'package:bark_admin/Models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum Status { Uninitialized, Authinticated, Authinticating, UnAuthinticated }

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;

  Future<FirebaseUser> signInGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

    if (user != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("user")
          .where("id", isEqualTo: user.uid)
          .getDocuments();

      final List<DocumentSnapshot> document = result.documents;
      if (document.length == 0) {
        Firestore.instance.collection("user").document(user.uid).setData(
              User.toJson(
                  age: 0,
                  email: user.email,
                  id: user.uid,
                  name: user.displayName,
                  orders: [],
                  phone: '',
                  photo: '',
                  registerMethod: 'Google',
                  reviews: [],
                  userCart: []),
            );
      }
    }

    return user;
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.UnAuthinticated;
    notifyListeners();
    //return Future.delayed(Duration.zero);
  }

  Future _onStateChanged(FirebaseUser user) async {
    if (user == null) {
      _status = Status.UnAuthinticated;
    } else {
      _user = user;
      _status = Status.Authinticated;
    }
    notifyListeners();
  }
}
