import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/presentation/screens/authentication/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentemail = AuthService().getUserEmail();
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
                Color(0xff007aff),
                AppColor.white,
              ],
            ),
          ),
        ),
        // Scaffold with transparent AppBar
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "My Profile",
              style: AppFont.appTitle(color: AppColor.principle),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Profile Picture
                const Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/5951/5951752.png'), // Replace with user's image URL
                  ),
                ),
                const SizedBox(height: 16),
                // User Name
                const Center(
                  child: Text(
                    "Ashxim", // Replace with user's name
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // User Email
                Center(
                  child: Text(
                    currentemail.toString(), // Replace with user's email
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // User Details Section
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    // Address
                    ListTile(
                      leading: Icon(Icons.home, color: Colors.white),
                      title: Text(
                        "Address",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "123 Main St, City, Country",
                        style: TextStyle(color: Colors.white54),
                      ), // Replace with actual address
                    ),
                    // Phone Number
                    ListTile(
                      leading: Icon(Icons.phone, color: Colors.white),
                      title: Text(
                        "Phone Number",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "+123 456 7890",
                        style: TextStyle(color: Colors.white54),
                      ), // Replace with user's phone number
                    ),
                    // Payment Method
                    ListTile(
                      leading: Icon(Icons.credit_card, color: Colors.white),
                      title: Text(
                        "Payment Method",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "**** **** **** 1234",
                        style: TextStyle(color: Colors.white54),
                      ), // Masked payment card
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Supabase.instance.client.auth.signOut();
                        },
                        child: const Text('Sign Out')),
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
