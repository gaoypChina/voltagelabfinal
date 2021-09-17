import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class GoogleSignInProvider extends ChangeNotifier {
  final googlesignin = GoogleSignIn();

  GoogleSignInAccount? user;

  Future signInWithGoogle() async {
    var box = Hive.box("userdata");
    final googleUser = await googlesignin.signIn();
    if (googleUser != null) {
      user = googleUser;
      box.put('name', user!.displayName);
      box.put('email', user!.email);
      box.put('photo', user!.photoUrl);
      box.put('id', user!.id);
      box.get('email');
      insertuserdata(user!.displayName!, user!.email, user!.photoUrl, user!.id);

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final data = await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
    }
    notifyListeners();
  }

  Future logout() async {
    var box = Hive.box("userdata");
    await googlesignin.disconnect();
    FirebaseAuth.instance.signOut();
    box.clear();
  }

  Future insertuserdata(String _fullname, _email, _photourl, _accountid) async {
    String url = "http://192.168.0.107/tanvir/user_input_data.php";
    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "full_name": _fullname,
          "email": _email,
          "photo_url": _photourl,
          "account_id": _accountid
        }));

    if (response.statusCode == 200) {
      print("Insert data successfull");
    }
  }
}
