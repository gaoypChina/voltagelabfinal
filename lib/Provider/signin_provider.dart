// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print, unrelated_type_equality_checks

import 'dart:convert';

import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/Sign_in_Screen/login.dart';
import 'package:voltagelab/Sign_in_Screen/pages/verification_email.dart';
import 'package:voltagelab/model/userinformation.dart';
import 'package:voltagelab/pages/home_page.dart';

class SignInProvider extends ChangeNotifier {


  final googlesignin = GoogleSignIn();
  EmailAuth? emailAuth;
  GoogleSignInAccount? user;
  Userinformation? userinformation;

  Future signInWithGoogle(BuildContext context) async {
    var box = Hive.box("userdata");
    final googleUser = await googlesignin.signIn();
    if (googleUser != null) {
      user = googleUser;
      box.put('name', user!.displayName);
      box.put('email', user!.email);
      box.put('photo', user!.photoUrl);
      box.put('id', user!.id);

      //type = 0 is google

      if (await userinfoverify(user!.email, 1) == false &&
          await userinfoverify(user!.email, 2) == false) {
        if (await userinfoverify(user!.email, 0) == false) {
          await insertuserdata(user!.displayName!, user!.email, "",
              user!.photoUrl, user!.id, 0, context);
          final googleAuth = await googleUser.authentication;
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          await FirebaseAuth.instance.signInWithCredential(credential);
          notifyListeners();
        }
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Email already use")));
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future logout() async {
    var box = Hive.box("userdata");
    await googlesignin.disconnect();
    FirebaseAuth.instance.signOut();
    box.clear();
    notifyListeners();
  }

  Future fromregistation(
      String _fullname, _email, _password, BuildContext context) async {
    await insertuserdata(_fullname, _email, _password, "", "", 2, context);
    notifyListeners();
  }

  Future gmailotpsend(String useremail) async {
    emailAuth = EmailAuth(
      sessionName: "Sample session",
    );
    bool result =
        await emailAuth!.sendOtp(recipientMail: useremail, otpLength: 6);
    return result;
  }

  Future gmailotpverify(
      String useremail, String otp, BuildContext context) async {
    bool result =
        emailAuth!.validateOtp(recipientMail: useremail, userOtp: otp);
    if (result == true) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Otp verification failed")));
    }
    return result;
  }

  Future insertuserdata(String _fullname, _email, _password, _photourl,
      _accountid, int _types, BuildContext context) async {
    // type = 2 is from
    String url = "http://192.168.0.107/tanvir/user_input_data.php";
    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "full_name": _fullname,
          "email": _email,
          "passwords": _password,
          "photo_url": _photourl,
          "account_id": _accountid,
          "types": _types
        }));

    if (response.statusCode == 200) {
      if (_types == 0) {
        print("Google login successfull");
      } else if (_types == 1) {
        print("Facebook login successfull");
      } else {
        gmailotpsend(_email).then((value) {
          if (value == true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmailVerificationPage(
                    useremail: _email,
                  ),
                ));
          }
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Otp Send Your Gmail")));
        notifyListeners();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("This email already use")));
      notifyListeners();
    }
  }

  Future<Userinformation?> fromlogin(
      String _email, _password, BuildContext context) async {
    String url =
        "http://192.168.0.107/tanvir/getuserdatabyemail.php?email=$_email&passwords=$_password";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      userinformation = userinformationFromJson(jsondata);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login Successfull")));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Account not Found")));
      notifyListeners();
    }
  }

  Future<bool> userinfoverify(String _email, int _type) async {
    String url =
        "http://192.168.0.107/tanvir/userinfoverify.php?email=${_email}&types=${_type}";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future facebooklogin() async {
    final LoginResult result = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile']);
    notifyListeners();
    return result;
  }
}
