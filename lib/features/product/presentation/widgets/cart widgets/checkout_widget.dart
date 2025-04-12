import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:my_ecom_app/features/product/presentation/screens/cart%20&%20payment/payment%20screen.dart';

class CheckoutWidget extends StatefulWidget {
  final double price;
  final double? discountPercentage;
  final int quantity;
  const CheckoutWidget(
      {super.key,
      required this.price,
      this.discountPercentage,
      required this.quantity});

  @override
  State<CheckoutWidget> createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  @override
  Widget build(BuildContext context) {
    double subtotal = widget.price;
    double discountFraction = (widget.discountPercentage ?? 0) / 100;
    double discountAmount = subtotal * discountFraction;
    double total = subtotal - discountAmount;
    double screenHeight = MediaQuery.of(context).size.height;
    return Material(
      child: Container(
        color: AppColor.principle,
        height: screenHeight * 0.45, // Adjust height as needed
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Free shipping notice

              const SizedBox(height: 16),
              // Promo code input with button
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF1F2433),
                        hintText: "click30",
                        hintStyle: const TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007AFF),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Apply",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Price breakdown
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal:",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "\$${subtotal.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Fee:",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Free',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount:",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${(widget.discountPercentage ?? 0).toStringAsFixed(0)}%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "\$${total.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Color(0xFF007AFF),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Center(
                child: SwipeButton.expand(
                  duration: const Duration(milliseconds: 800),
                  width: 150,
                  thumb: const Icon(
                    Icons.double_arrow_rounded,
                    color: Colors.white,
                  ),
                  activeTrackColor: const Color(0xFF007AFF),
                  onSwipe: () {
                    if (widget.price > 0) {
                      final double total = widget.price -
                          (widget.price *
                              ((widget.discountPercentage ?? 0) / 100));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                    subtotal: widget.price,
                                    discountPercentage:
                                        widget.discountPercentage ?? 0,
                                    total: total,
                                    totalQuantity: widget.quantity,
                                  )));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please add items to your cart"),
                        ),
                      );
                    }
                  },
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007AFF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    label: const Padding(
                      padding: EdgeInsets.only(left: 35),
                      child: Text(
                        "Checkout",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
