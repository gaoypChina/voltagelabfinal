import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/payment_invoice.dart';

class GenerateInvoice extends StatefulWidget {
  const GenerateInvoice({Key? key}) : super(key: key);

  @override
  _GenerateInvoiceState createState() => _GenerateInvoiceState();
}

class _GenerateInvoiceState extends State<GenerateInvoice> {
  parmissionhandeler() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    } else {}
  }

  @override
  void initState() {
    parmissionhandeler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final payment = Provider.of<PaymentInvoiceprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('pdf'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                payment.generate_payment_invoice();
              },
              child: const Text('Show Pdf'))
        ],
      ),
    );
  }
}
