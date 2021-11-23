// ignore_for_file: prefer_typing_uninitialized_variables, unused_field, prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:voltagelab/helper/global.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  final _formkey = GlobalKey<FormState>();
  late final _ratingController;
  late double _rating;

  String? feedbacktext;

  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 3.0;
  bool _isRTLMode = false;
  bool _isVertical = false;

  IconData? _selectedIcon;

  Future feedbacksend() async {
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
      ..recipients.add("vlapp")
      ..subject = 'FeedBack'
      ..text = feedbacktext;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("FeedBack send successfull")));
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  validationchack(BuildContext context) {
    final from = _formkey.currentState;
    if (from!.validate()) {
      from.save();
      feedbacksend();
    }
  }

  @override
  void initState() {
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "FeedBack",
          style: Global.enPostListAppbarText,
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                  print(rating);
                },
              ),
            ),
            Text("Rating: $_rating", style: GoogleFonts.lato(),),
            Form(
              key: _formkey,
              child: Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  minLines: 1,
                  maxLines: 5,
                  onSaved: (newValue) {
                    setState(() {
                      feedbacktext = newValue;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Write Something";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Tell us your opinion",
                      hintStyle: Global.encategorySearchhintText),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                validationchack(context);
              },
              child: Text(
                "Send FeedBack",
                style: GoogleFonts.lato(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
              color: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}
