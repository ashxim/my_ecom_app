import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/presentation/screens/cart%20&%20payment/facturation%20page.dart';

class PaymentPage extends StatefulWidget {
  final double subtotal;
  final double discountPercentage;
  final double total;
  final int totalQuantity;

  const PaymentPage({
    Key? key,
    required this.subtotal,
    required this.discountPercentage,
    required this.total,
    required this.totalQuantity,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isProcessing = false;

  Future<void> _processPayment() async {
    setState(() {
      _isProcessing = true;
    });

    // Simulate payment processing delay
    await Future.delayed(const Duration(seconds: 3));

    // Simulate saving the order (you could trigger an event here instead)
    print(
        "Order saved: Items: ${widget.totalQuantity}, Total: \$${widget.total.toStringAsFixed(2)}");

    // Navigate to the Facturation (invoice) page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FacturationPage(
          subtotal: widget.subtotal,
          discountPercentage: widget.discountPercentage,
          total: widget.total,
          totalQuantity: widget.totalQuantity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: AppColor.principle,
      ),
      body: Center(
        child: _isProcessing
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text("Processing Payment...",
                      style: AppFont.normalText(color: Colors.black)),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total to Pay: \$${widget.total.toStringAsFixed(2)}",
                    style: AppFont.widgetTitle(color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _processPayment,
                    child: const Text("Confirm Payment"),
                  ),
                ],
              ),
      ),
    );
  }
}
