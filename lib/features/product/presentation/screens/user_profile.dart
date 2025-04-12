import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/presentation/screens/authentication/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget({super.key});

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  // Initialize user details (assume AuthService provides these)
  late String displayName;
  late String email;
  // Set a default avatar which can be changed from the list.
  String _selectedAvatar =
      'https://cdn-icons-png.flaticon.com/512/5951/5951752.png';

  // Sample list of avatars; you can replace these URLs with those from any package or assets.
  final List<String> avatarList = [
    'https://cdn-icons-png.flaticon.com/512/5951/5951752.png',
    'https://cdn-icons-png.flaticon.com/512/2922/2922506.png',
    'https://cdn-icons-png.flaticon.com/512/2922/2922510.png',
    'https://cdn-icons-png.flaticon.com/512/2922/2922511.png',
    'https://cdn-icons-png.flaticon.com/512/2922/2922508.png',
  ];

  @override
  void initState() {
    super.initState();

    displayName = AuthService().getUserName() ?? "John Doe";
    email = AuthService().getUserEmail() ?? "example@domain.com";
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.Grey.withOpacity(0.9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: avatarList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final avatarUrl = avatarList[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAvatar = avatarUrl;
                  });
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(avatarUrl),
                  child: _selectedAvatar == avatarUrl
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.blueAccent, width: 3),
                          ),
                        )
                      : null,
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
            actions: [
              IconButton(
                icon: const Icon(Icons.light_mode, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(_selectedAvatar),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _showAvatarPicker,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.blueAccent,
                            child: const Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Implement edit functionality here
                        // For example, show a dialog to edit the name
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Edit Name"),
                              content: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    displayName = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter your name",
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Save"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    email,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.white38),
                const ListTile(
                  leading: Icon(Icons.home, color: Colors.white),
                  title: Text(
                    "Address",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "123 Main St, City, Country",
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.phone, color: Colors.white),
                  title: Text(
                    "Phone Number",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "+123 456 7890",
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.credit_card, color: Colors.white),
                  title: Text(
                    "Payment Method",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "**** **** **** 1234",
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
                const Divider(color: Colors.white38),
                ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.white),
                  title: const Text(
                    "Manage Addresses",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.white54),
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                    ),
                    onPressed: () {
                      Supabase.instance.client.auth.signOut();
                    },
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
