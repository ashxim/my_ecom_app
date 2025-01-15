import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Material(
      child: Container(
        color: AppColor.principle,
        height: screenHeight, // Full screen height
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/5951/5951752.png'), // Replace with user's image URL
                ),
              ),
              const SizedBox(height: 16),

              // User Name
              Center(
                child: Text(
                  "John Doe", // Replace with user's name
                  style: const TextStyle(
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
                  "johndoe@example.com", // Replace with user's email
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // User Details Section
              Expanded(
                child: ListView(
                  children: [
                    // Address
                    ListTile(
                      leading: Icon(Icons.home, color: Colors.white),
                      title: Text("Address",
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text("123 Main St, City, Country",
                          style: TextStyle(
                              color: Colors
                                  .white54)), // Replace with actual address
                    ),

                    // Phone Number
                    ListTile(
                      leading: Icon(Icons.phone, color: Colors.white),
                      title: Text("Phone Number",
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text("+123 456 7890",
                          style: TextStyle(
                              color: Colors
                                  .white54)), // Replace with user's phone number
                    ),

                    // Payment Method
                    ListTile(
                      leading: Icon(Icons.credit_card, color: Colors.white),
                      title: Text("Payment Method",
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text("**** **** **** 1234",
                          style: TextStyle(
                              color: Colors.white54)), // Masked payment card
                    ),
                  ],
                ),
              ),

              // Edit Profile Button
            ],
          ),
        ),
      ),
    );
  }
}
