import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_ecom_app/features/product/presentation/screens/authentication/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onToggle;
  const LoginScreen({super.key, required this.onToggle});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    try {
      await authService.signInWithEmailPass(email, password);
      // If successful, show a success snackbar.
      const successSnackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'succeed!',
          message: 'Logged In!',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
    } catch (e) {
      final errorSnackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: 'Something went wrong: $e',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    }
  }

  void signInWithGoogle() async {
    try {
      bool success = await authService.signInWithGoogle();
      if (success) {
        print('Signed in with Google successfully');
        // Navigate to the home screen or update the UI
      } else {
        print('Failed to sign in with Google');
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

// Sign in with Facebook
  void signInWithFacebook() async {
    try {
      bool success = await authService.signInWithFacebook();
      if (success) {
        print('Signed in with Facebook successfully');
        // Navigate to the home screen or update the UI
      } else {
        print('Failed to sign in with Facebook');
      }
    } catch (error) {
      print('Error signing in with Facebook: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          _buildTextField("Email Address", controller: _emailController),
          _buildTextField("Password",
              isPassword: true, controller: _passwordController),
          _buildAuthButton("Sign In"),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.google)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.facebook))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String hint,
      {bool isPassword = false, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, bottom: 20, right: 30, top: 10),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildAuthButton(String label) {
    return ElevatedButton.icon(
      icon: const Icon(Iconsax.login),
      style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
      onPressed: () {
        login();
      },
      label: Text(label),
    );
  }
}
