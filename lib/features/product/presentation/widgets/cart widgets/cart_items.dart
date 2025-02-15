import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/domain/entities/cart_entities.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/cart/cart_event.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Bloc/cart/cart_bloc.dart';

class CartItems extends StatefulWidget {
  final String? title;
  final double? price;
  final int quantity;
  final String? thumbnail;
  final int id;
  final int productId;
  final double discountPercentage;

  const CartItems({
    super.key,
    required this.title,
    required this.price,
    required this.quantity,
    required this.thumbnail,
    required this.id,
    required this.productId,
    required this.discountPercentage,
  });

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  Widget build(BuildContext context) {
    final SupabaseClient client = Supabase.instance.client;
    final String? userId = client.auth.currentUser?.id;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: screenWidth * 1,
          height: screenHeight * 0.2,
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
                  widget.thumbnail!,
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
                        widget.title!,
                        style: AppFont.widgetTitle(
                            color: AppColor.Black, fontSize: 18),
                      ),
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        "\$${widget.price}",
                        style: AppFont.widgetTitle(
                            color: AppColor.principle, fontSize: 16),
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
                          if (userId != null) {
                            context.read<CartBloc>().add(
                                  RemoveFromCartEvent(
                                    productId: widget.productId,
                                    userId: userId,
                                  ),
                                );
                          } else {
                            print('User is not authenticated');
                          }
                        },
                        icon: const Icon(
                          Icons.delete_outline_sharp,
                          color: AppColor.principle,
                          size: 30,
                        )),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              context.read<CartBloc>().add(
                                    UpdateCartEvent(
                                      userId:
                                          userId!, // Replace with actual user ID logic
                                      productId: widget.productId,
                                      quantity: widget.quantity + 1,
                                    ),
                                  );
                            },
                            icon: const Icon(
                              FluentIcons.add_circle_12_regular,
                              color: AppColor.principle,
                              size: 30,
                            )),
                        Text(
                          widget.quantity.toString(),
                          style: AppFont.normalText(
                              color: AppColor.white, fontSize: 22),
                        ),
                        IconButton(
                            onPressed: () {
                              context.read<CartBloc>().add(
                                    UpdateCartEvent(
                                      userId:
                                          userId!, // Replace with actual user ID logic
                                      productId: widget.productId,
                                      quantity: widget.quantity - 1,
                                    ),
                                  );
                              if (widget.quantity <= 1) {
                                context.read<CartBloc>().add(
                                      RemoveFromCartEvent(
                                        productId: widget.productId,
                                        userId: userId,
                                      ),
                                    );
                              }
                            },
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
