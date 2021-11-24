import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/signin_provider.dart';
import 'package:voltagelab/Sign_in_Screen/pages/Recover_Password/recovery_code_send.dart';

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage({Key? key}) : super(key: key);

  @override
  _RecoveryPasswordPageState createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final _formkey = GlobalKey<FormState>();

  String? email;

  validationchack(BuildContext context) async {
    final signin = Provider.of<SignInProvider>(context, listen: false);
    final from = _formkey.currentState;
    if (from!.validate()) {
      from.save();
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
      await signin.fromgetlogindatabyemail(email!).then((value) {
        if (value == true) {
          signin.gmailotpsend(email!);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Recovery Code Send')));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecoveryCodeSendPAge(email: email!)));
          EasyLoading.dismiss();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Email Not Found')));
          EasyLoading.dismiss();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[Color(0xFF8E66FB), Color(0xFF4172F7)],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 1.0),
                stops: <double>[0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
                "ইমেইলে পাসওয়ার্ড পুনরুদ্ধার করুন",
                style: GoogleFonts.hindSiliguri(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Card(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: 300,
                  child: Column(
                    children: [
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 0.0, left: 25.0, right: 25.0),
                              child: TextFormField(
                                onSaved: (newValue) {
                                  setState(() {
                                    email = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "আপনার ইমেইল এড্রেস দিন";
                                  } else if (!value.contains('@gmail')) {
                                    return "সঠিক ইমেইল এড্রেস প্রদান করুন!!!";
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.envelope,
                                    color: Colors.black,
                                    size: 22.0,
                                  ),
                                  hintText: 'ইমেইল এড্রেস',
                                  hintStyle: GoogleFonts.hindSiliguri(fontSize: 17.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            validationchack(context);
                          },
                          child: Text("যাচাই করুন",style: GoogleFonts.hindSiliguri(),))
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   flex: 2,
              //   child: Container(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
