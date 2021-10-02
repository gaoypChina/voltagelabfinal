import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailSendPage extends StatefulWidget {
  const EmailSendPage({Key? key}) : super(key: key);

  @override
  _EmailSendPageState createState() => _EmailSendPageState();
}

class _EmailSendPageState extends State<EmailSendPage> {
  emailsend() async {
    String host = 'voltagelab.com';

    int port = 587;
    String name = 'tanvir';
    bool ignoreBadCertificate = false;
    bool ssl = false;
    bool allowInsecure = false;
    String? xoauth2Token;
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
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Tanvir')
      ..recipients.add('shakilhassan887@gmail.com')
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Test Dart Mailer library'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('email send'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                emailsend();
              },
              child: Text('send email'))
        ],
      ),
    );
  }
}
