import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.14,
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
                  "https://www.pngmart.com/files/15/Apple-iPhone-11-PNG-File.png",
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
                        'Iphone 15 pro max',
                        style: AppFont.widgetTitle(
                            color: AppColor.principle, fontSize: 18),
                      ),
                      Text(
                        '200£',
                        style: AppFont.widgetTitle(
                            color: AppColor.principle, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FluentIcons.add_circle_12_regular,
                          size: 30,
                        )),
                    Text(
                      '1',
                      style: AppFont.normalText(
                          color: AppColor.white, fontSize: 22),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FluentIcons.subtract_circle_12_regular,
                          size: 30,
                        ))
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
