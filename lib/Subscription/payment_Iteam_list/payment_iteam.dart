import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voltagelab/Subscription/Payment_page/payment_page.dart';

class PaymentListPage extends StatefulWidget {
  final int package_price;
  const PaymentListPage({Key? key, required this.package_price})
      : super(key: key);

  @override
  _PaymentListPageState createState() => _PaymentListPageState();
}

class _PaymentListPageState extends State<PaymentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment List'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      payment_name: 'Bkash',
                      package_price: widget.package_price,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Container(
                    child: SvgPicture.asset(
                      'images/bikash.svg',
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Bikash',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      payment_name: 'Nagad',
                      package_price: widget.package_price,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Container(
                    child: SvgPicture.asset(
                      'images/Nagad-Logo.svg',
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Nagad',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
