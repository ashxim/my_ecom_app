import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/cart/cart_event.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Bloc/cart/cart_bloc.dart';

class CartItems extends StatelessWidget {
  final String? title;
  final double? price;
  final int quantity;
  final String? thumbnail;
  final int? id;

  const CartItems({
    super.key,
    required this.title,
    required this.price,
    required this.quantity,
    required this.thumbnail,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: screenWidth * 1,
          height: screenHeight * 0.17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // Semi-transparent blue
          ),
          child: Row(
            children: [
              // Product Image
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  thumbnail!,
                  height: screenHeight * 0.15,
                  width: screenWidth * 0.2,
                  fit: BoxFit.cover,
                ),
              ),

              // Product Info
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        title!,
                        style: AppFont.widgetTitle(
                            color: AppColor.Black, fontSize: 18),
                      ),
                      Text(
                        "\$$price",
                        style: AppFont.widgetTitle(
                            color: AppColor.principle, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          final SupabaseClient client =
                              Supabase.instance.client;
                          final String? userId = client.auth.currentUser?.id;
                          context.read<CartBloc>().add(RemoveFromCartEvent(
                                productId: id!,
                                userId: userId!,
                              ));
                        },
                        icon: Icon(
                          Icons.delete_outline_sharp,
                          color: AppColor.principle,
                          size: 30,
                        )),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FluentIcons.add_circle_12_regular,
                              color: AppColor.principle,
                              size: 30,
                            )),
                        Text(
                          quantity.toString(),
                          style: AppFont.normalText(
                              color: AppColor.white, fontSize: 22),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FluentIcons.subtract_circle_12_regular,
                              color: AppColor.principle,
                              size: 30,
                            ))
                      ],
                    ),
                  ],
                ),
              )
              // Action Buttons
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
