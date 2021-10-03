import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      await signin.userinfoverify(email!, 2).then((value) {
        if (value == true) {
          signin.gmailotpsend(email!);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Recovery Email Send')));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecoveryCodeSendPAge(email: email!)));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Email Not Found')));
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
              const Text(
                "Recover By Email",
                style: TextStyle(fontSize: 20, color: Colors.white),
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
                                    return "Enter your Email Address";
                                  } else if (!value.contains('@gmail')) {
                                    return "Enter your Valid Email Address";
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.envelope,
                                    color: Colors.black,
                                    size: 22.0,
                                  ),
                                  hintText: 'Email Address',
                                  hintStyle: TextStyle(fontSize: 17.0),
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
                          child: const Text("Verify"))
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
