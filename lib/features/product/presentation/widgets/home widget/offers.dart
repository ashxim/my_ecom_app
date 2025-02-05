import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Ads extends StatefulWidget {
  const Ads({super.key});

  @override
  _AdsState createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // List of Lottie animation assets with corresponding ad texts.
  final List<Map<String, String>> _adData = [
    {
      'asset': 'lib/core/assets/onboarding/4.json',
      'text': 'Discover the latest trends in fashion!'
    },
    {
      'asset': 'lib/core/assets/onboarding/1.json',
      'text': 'Sit home , and Click shop !'
    },
    {
      'asset': 'lib/core/assets/onboarding/5.json',
      'text': 'We deliver to your door.'
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % _adData.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 40, right: 20),
      child: SizedBox(
        height: screenHeight * 0.3,
        width: screenWidth * 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: PageView.builder(
            controller: _pageController,
            itemCount: _adData.length,
            itemBuilder: (context, index) {
              return Container(
                color:
                    Colors.transparent, // Optional background color for each ad
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      _adData[index]['asset']!,
                      height: screenHeight * 0.25,
                      width: screenWidth * 0.5,
                    ),
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        _adData[index]['text']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
