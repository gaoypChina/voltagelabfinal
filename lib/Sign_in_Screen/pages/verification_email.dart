import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/signin_provider.dart';

class EmailVerificationPage extends StatefulWidget {
  final String fullname, email, password;
  const EmailVerificationPage({Key? key, required this.fullname, required this.email, required this.password, })
      : super(key: key);

  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final _formkey = GlobalKey<FormState>();
  String? otp;

  validationchack(BuildContext context) {
    final signin = Provider.of<SignInProvider>(context, listen: false);
    final from = _formkey.currentState;
    if (from!.validate()) {
      from.save();
      signin.gmailotpverify(widget.fullname, widget.email, widget.password, otp!,context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signin = Provider.of<SignInProvider>(context);
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
            children: [
              Expanded(
                flex: 2,
                child: SvgPicture.asset(
                  'images/otp.svg',
                  height: 220,
                ),
              ),
              Expanded(
                flex: 2,
                child: Card(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: SizedBox(
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            "Verification",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Form(
                          key: _formkey,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: TextFormField(
                              onSaved: (newValue) {
                                otp = newValue;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter your otp";
                                }
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Enter Otp",
                                  prefixIcon: Icon(FontAwesomeIcons.userLock)),
                            ),
                          ),
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
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
