import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/btm_nav_bar.dart';

import 'card_clickshop.dart';

class OnboardingScreenOne extends StatelessWidget {
  OnboardingScreenOne({super.key});
  final data = [
    CardClickShopData(
      title: "Explore",
      subtitle:
          "Dive into a curated world of beauty, tech, cars, and more—all at your fingertips.",
      image: Lottie.asset('lib/core/assets/onboarding/1.json'),
      backgroundColor: AppColor.principle.withOpacity(0.2),
      titleColor: Colors.pink,
      subtitleColor: AppColor.principle,
      background: Lottie.asset("lib/core/assets/onboarding/background.json",
          width: 200, height: 200),
    ),
    CardClickShopData(
      title: "Discover",
      subtitle:
          "Discover diverse collections that blend innovation with style across every category.",
      image: Lottie.asset("lib/core/assets/onboarding/4.json"),
      backgroundColor: AppColor.principle.withOpacity(0.2),
      titleColor: Colors.pink,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
      //  background: LottieBuilder.asset("assets/animation/bg-2.json"),
    ),
    CardClickShopData(
      title: "Showcase",
      subtitle:
          "Experience a dynamic selection from cosmetics to cutting-edge gadgets and luxurious rides",
      image: LottieBuilder.asset("lib/core/assets/onboarding/5.json"),
      backgroundColor: AppColor.principle.withOpacity(0.2),
      titleColor: Colors.pink,
      subtitleColor: AppColor.principle,
      background: Lottie.asset("lib/core/assets/onboarding/background.json",
          width: 200, height: 200),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return CardClickShop(data: data[index]);
        },
        onFinish: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BtmNavBar()),
          );
        },
        nextButtonBuilder: (context) => const Icon(
          color: AppColor.blue,
          Icons.arrow_forward_ios_outlined,
          size: 30,
        ),
      ),
    );
  }
}
