// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailSendPage extends StatefulWidget {
  const EmailSendPage({Key? key}) : super(key: key);

  @override
  _EmailSendPageState createState() => _EmailSendPageState();
}

class _EmailSendPageState extends State<EmailSendPage> {
  final _fromkey = GlobalKey<FormState>();

  validationchack(BuildContext context) {
    final from = _fromkey.currentState;
    if (from!.validate()) {
      from.save();
    }
  }

  emailsend() async {
    var box = Hive.box('verificationnumber');
    Random random = Random();
    int randomNumber = random.nextInt(99) + 1089;
    box.put('verify', randomNumber);

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
      ..from = Address(username, 'Tanvir')
      ..recipients.add('shakilhassan887@gmail.com')
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

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('verificationnumber');
    return Scaffold(
      appBar: AppBar(
        title: const Text('email send'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                emailsend();
              },
              child: const Text('send email')),
          Container(
            margin: const EdgeInsets.all(10),
            child: Form(
              key: _fromkey,
              child: TextFormField(
                validator: (value) {
                  if (value == box.get('verify').toString()) {
                    print(box.get('verify'));
                    return 'verifyed successfull';
                  } else {
                    print(box.get('verify'));
                    return 'not verifyed';
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'code',
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                validationchack(context);
              },
              child: const Text('verify'))
        ],
      ),
    );
  }
}
