// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:voltagelab/Pdf_invoice/Api/pdf_api.dart';
import 'package:voltagelab/Pdf_invoice/Api/pdfinvoice_api.dart';
import 'package:voltagelab/Pdf_invoice/model/customer.dart';
import 'package:voltagelab/Pdf_invoice/model/invoice.dart';
import 'package:voltagelab/Pdf_invoice/model/supplier.dart';
import 'package:flutter/material.dart';

class PaymentInvoiceprovider extends ChangeNotifier {
  Future generate_payment_invoice() async {
    final date = DateTime.now();
    final dueDate = date.add(const Duration(days: 7));
    final invoice = Invoice(
        info: InvoiceInfo(
          date: date,
          dueDate: dueDate,
          description: 'My description...',
          number: '${DateTime.now().year}-9999',
        ),
        supplier: const Supplier(
          name: 'Sarah Field',
          address: 'Sarah Street 9, Beijing, China',
          paymentInfo: 'https://paypal.me/sarahfieldzz',
        ),
        customer: const Customer(
          name: 'Apple Inc.',
          address: 'Apple Street, Cupertino, CA 95014',
        ),
        items: [
          InvoiceItem(
            description: 'Coffee',
            date: DateTime.now(),
            quantity: 3,
            vat: 0.19,
            unitPrice: 5.99,
          ),
        ]);

    final pdfFile = await PdfInvoiceApi.generate(invoice);
    PdfApi.openFile(pdfFile);
  }
}
