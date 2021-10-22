import 'package:flutter/material.dart';

class InternetDisconnectpage extends StatelessWidget {
  const InternetDisconnectpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(Icons.wifi_off),
            Text("No Internet"),
          ],
        ),
      ),
    );
  }
}
