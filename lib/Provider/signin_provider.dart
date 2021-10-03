// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print, unrelated_type_equality_checks

import 'dart:convert';
import 'dart:math';

import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:voltagelab/Sign_in_Screen/login.dart';
import 'package:voltagelab/Sign_in_Screen/pages/verification_email.dart';
import 'package:voltagelab/model/userinformation.dart';
import 'package:voltagelab/pages/homepage.dart';
import 'package:voltagelab/pages/homepage2.dart';

class SignInProvider extends ChangeNotifier {
  final googlesignin = GoogleSignIn();
  EmailAuth? emailAuth;
  GoogleSignInAccount? user;
  Userinformation? userinformation;

  bool loading = false;

  Future signInWithGoogle(BuildContext context) async {
    googlesignin.signOut();
    final googleUser = await googlesignin.signIn();
    if (googleUser != null) {
      user = googleUser;
      //type = 0 is google

      if (await userinfoverify(user!.email, 1) == false &&
          await userinfoverify(user!.email, 2) == false) {
        if (await userinfoverify(user!.email, 0) == false) {
          EasyLoading.show(status: 'loading...');
          await insertuserdata(user!.displayName!, user!.email, "",
              user!.photoUrl, user!.id, 0, context);
          singleuserdatabyemail(user!.email);
          final googleAuth = await googleUser.authentication;
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          await FirebaseAuth.instance.signInWithCredential(credential);

          notifyListeners();
        } else {
          EasyLoading.show(status: 'loading...');
          singleuserdatabyemail(user!.email);
          final googleAuth = await googleUser.authentication;
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          await FirebaseAuth.instance.signInWithCredential(credential);
          notifyListeners();
        }
      } else {
        snakbar(context, 'Email already use');
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future logout(BuildContext context) async {
    var box = Hive.box("userdata");
    if (box.get('types') == "0") {
      await googlesignin.disconnect();
      FirebaseAuth.instance.signOut();
      box.clear();
    } else {
      box.clear();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }

    notifyListeners();
  }

  Future fromregistation(
      String _fullname, _email, _password, BuildContext context) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.custom,
        indicator: SpinKitThreeBounce(
          size: 30,
          itemBuilder: (context, index) {
            return DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: index.isEven ? Colors.red : Colors.green));
          },
        ));
    //type = 2 is from registation
    if (await userinfoverify(_email, 0) == false &&
        await userinfoverify(_email, 2) == false) {
      gmailotpsend(_email);
      snakbar(context, "email send");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmailVerificationPage(
            fullname: _fullname,
            email: _email,
            password: _password,
          ),
        ),
      );

      EasyLoading.dismiss();
      notifyListeners();
    } else {
      EasyLoading.dismiss();
      snakbar(context, "This email already use");
    }
    notifyListeners();
  }

  Future gmailotpsend(String useremail) async {
    var box = Hive.box('verificationnumber');
    Random random = Random();
    int randomNumber = random.nextInt(99) + 1089;
    box.put('verify', randomNumber);
    box.put('verifyemail', useremail);
    print(randomNumber);

    String host = 'voltagelab.com';

    String name = 'Voltage Lab';
    bool ignoreBadCertificate = false;
    bool ssl = false;
    bool allowInsecure = false;
    String username = 'otp@voltagelab.com';
    String password = 'mindofEYE@1';

    final smtpServer = SmtpServer(
      host,
      port: 587,
      name: name,
      allowInsecure: allowInsecure,
      username: username,
      password: password,
      ssl: ssl,
      ignoreBadCertificate: ignoreBadCertificate,
    );
    final message = Message()
      ..from = Address(username, name)
      ..recipients.add(useremail)
      ..subject = 'Verification Code'
      ..text = 'Verification code: ${box.get('verify')}';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Future gmailotpverify(String _fullname, _email, _password, String otp,
      BuildContext context) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.custom,
        indicator: SpinKitThreeBounce(
          size: 30,
          itemBuilder: (context, index) {
            return DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: index.isEven ? Colors.red : Colors.green));
          },
        ));
    var box = Hive.box('verificationnumber');
    if (otp == box.get('verify').toString() &&
        _email == box.get('verifyemail')) {
      await insertuserdata(_fullname, _email, _password, "", "", 2, context);

      EasyLoading.dismiss();
    } else {
      snakbar(context, 'Otp verification failed');

      EasyLoading.dismiss();
    }
  }

  Future recoveryotpverify(String _email, String otp) async {
    bool result = emailAuth!.validateOtp(recipientMail: _email, userOtp: otp);
    return result;
  }

  Future insertuserdata(String _fullname, _email, _password, _photourl,
      _accountid, int _types, BuildContext context) async {
    // type = 2 is from
    String url = "http://api.voltagelab.com/vl-app/user_input_data.php";
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
        userinfosave(_fullname, _email, "", "", "2");
        snakbar(context, 'Registation Successfull');
        redirectpage(context);

        notifyListeners();
      }
    } else {
      snakbar(context, 'This email already use');
      notifyListeners();
    }
  }

  Future<Userinformation?> fromlogin(
      String _email, _password, BuildContext context) async {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.custom,
        indicator: SpinKitThreeBounce(
          size: 30,
          itemBuilder: (context, index) {
            return DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: index.isEven ? Colors.red : Colors.green));
          },
        ));
    String url =
        "http://api.voltagelab.com/vl-app/getuserdatabyemailandpassword.php?email=$_email&passwords=$_password";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      userinformation = userinformationFromJson(jsondata);
      userinfosave(
          userinformation!.fullName,
          userinformation!.email,
          userinformation!.photoUrl,
          userinformation!.accountId,
          userinformation!.types);

      EasyLoading.dismiss();
      snakbar(context, 'Login Successfull');
      redirectpage(context);
      notifyListeners();
    } else {
      EasyLoading.dismiss();
      snakbar(context, "Account Not Found");
      notifyListeners();
    }
  }

  Future<bool> userinfoverify(String _email, int _type) async {
    String url =
        "http://api.voltagelab.com/vl-app/userinfoverify.php?email=${_email}&types=${_type}";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Userinformation?> singleuserdatabyemail(String email) async {
    String url =
        "http://api.voltagelab.com/vl-app/getuserdatabyemail.php?email=${email}";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      userinformation = userinformationFromJson(response.body);
      userinfosave(
          userinformation!.fullName,
          userinformation!.email,
          userinformation!.photoUrl,
          userinformation!.accountId,
          userinformation!.types);
      notifyListeners();
      return userinformation;
    }
  }

  void redirectpage(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
  }

  void snakbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void userinfosave(String name, email, photourl, accountid, types) {
    var box = Hive.box('userdata');
    box.put('name', name);
    box.put('email', email);
    box.put('photo', photourl);
    box.put('id', accountid);
    box.put('types', types);
    notifyListeners();
  }

  Future userpassswordupdate(String _email, int _types, String _newpassword,
      BuildContext context) async {
    String url =
        "http://api.voltagelab.com/vl-app/updatepasswordbyemail.php?email=${_email}&types=${_types}";
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {"passwords": _newpassword},
      ),
    );
    if (response.statusCode == 200) {
      snakbar(context, 'Your Password Update');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage2(),
          ));
      notifyListeners();
      return true;
    } else {
      snakbar(context, 'Your Password not upate. Please try again');
      notifyListeners();
      return false;
    }
  }

  // Future facebooklogin() async {

  //   final LoginResult result = await FacebookAuth.i.login(permissions: ['email', 'public_profile']);
  //   notifyListeners();
  //   return result;
  // }
}
