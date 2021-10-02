import 'package:flutter/material.dart';
import 'package:voltagelab/Subscription/Payment_page/payment_page.dart';

class PaymentListPage extends StatefulWidget {
  final int package_price;
  final String subscription_pack_name;
  const PaymentListPage({Key? key, required this.package_price, required this.subscription_pack_name})
      : super(key: key);

  @override
  _PaymentListPageState createState() => _PaymentListPageState();
}

class _PaymentListPageState extends State<PaymentListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment List'),
      ),
      body: Column(
        children: [
          paymentiteamlist(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      payment_name: 'Bkash',
                      package_price: widget.package_price,
                      subscription_pack_name: widget.subscription_pack_name,
                    ),
                  ),
                );
              },
              imagechild: Image.asset(
                'images/bikash.png',
                height: 50,
              ),
              name: 'Bkash'),
          paymentiteamlist(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      payment_name: 'Nagad',
                      package_price: widget.package_price,
                      subscription_pack_name: widget.subscription_pack_name,
                    ),
                  ),
                );
              },
              imagechild: Image.asset(
                'images/nagad.png',
                height: 50,
              ),
              name: 'Nagad'),
        ],
      ),
    );
  }

  Widget paymentiteamlist(
      {GestureTapCallback? onTap, Widget? imagechild, String? name}) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.indigoAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(child: imagechild),
            const SizedBox(width: 10),
            Text(
              name!,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}