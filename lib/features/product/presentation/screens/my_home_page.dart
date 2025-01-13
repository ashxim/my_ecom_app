import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/presentation/screens/product_details.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/categories.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/hot_deals.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/offers.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        // Gradient background
        Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
              AppColor.Grey,
              Color(0xff0ff007aff),
              AppColor.white
            ]))),
        // Scaffold with transparent AppBar
        Scaffold(
          backgroundColor: Colors.transparent, // Make scaffold transparent
          appBar: AppBar(
            backgroundColor: Colors.transparent, // Fully transparent
            elevation: 0, // Remove shadow
            title: Text(
              "ClickShop",
              style: AppFont.appTitle(color: AppColor.principle),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    size: 28,
                    Icons.shopping_bag_outlined,
                    color: AppColor.principle,
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  // offers widget
                  width: double.maxFinite,
                  height: 180,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) => const Offers(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Categories',
                          style: AppFont.widgetTitle(
                              color: AppColor.principle, fontSize: 18)),
                      InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text('See all',
                                  style: AppFont.widgetTitle(
                                      color: AppColor.white)),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColor.white,
                                size: 15,
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  // categories widget
                  width: double.maxFinite,
                  height: 120,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) => const Categories(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hot seals',
                          style: AppFont.widgetTitle(
                              color: AppColor.principle, fontSize: 18)),
                      InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text('See all',
                                  style: AppFont.widgetTitle(
                                      color: AppColor.white)),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColor.white,
                                size: 15,
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                Padding(
                  //  hot seals widget
                  padding: const EdgeInsets.all(8.0),

                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 8,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductDetails(),
                              ));
                        },
                        child: const HotDeals(
                          icon: Icons.favorite_border_outlined,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
