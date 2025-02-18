import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';

class FacturationPage extends StatelessWidget {
  final double subtotal;
  final double discountPercentage;
  final double total;
  final int totalQuantity;

  const FacturationPage({
    Key? key,
    required this.subtotal,
    required this.discountPercentage,
    required this.total,
    required this.totalQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
        backgroundColor: AppColor.principle,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Invoice", style: AppFont.appTitle(color: Colors.black)),
            const SizedBox(height: 20),
            Text("Total Items: $totalQuantity",
                style: AppFont.normalText(color: Colors.black)),
            Text("Subtotal: \$${subtotal.toStringAsFixed(2)}",
                style: AppFont.normalText(color: Colors.black)),
            Text("Discount: ${discountPercentage.toStringAsFixed(0)}%",
                style: AppFont.normalText(color: Colors.black)),
            Text("Total: \$${total.toStringAsFixed(2)}",
                style: AppFont.widgetTitle(color: Colors.black)),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to home or orders page.
                  // Here, we pop until the first route (for example, the home screen)
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("Finish"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
