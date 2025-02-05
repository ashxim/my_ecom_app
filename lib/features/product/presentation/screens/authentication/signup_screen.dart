import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_ecom_app/features/product/presentation/screens/authentication/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onToggle;
  const SignUpScreen({super.key, required this.onToggle});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  void signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmpassword = _confirmPasswordController.text;
    if (password != confirmpassword) {
      const successSnackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: "password doesn't match",
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
      return;
    }
    try {
      await authService.signUpWithEmailPass(email, password);
      // If successful, show a success snackbar.
      const successSnackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Signed up!',
          message: 'you can now sign in!',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
      Future.delayed(const Duration(seconds: 2), () {
        widget.onToggle(); // Call the toggle to push to the sign in page.
      });
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Sign Up",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          _buildTextField(
            "Full Name",
            controller: _nameController,
          ),
          _buildTextField("Email Address", controller: _emailController),
          _buildTextField("Password",
              isPassword: true, controller: _passwordController),
          _buildTextField("Confirm Password",
              isPassword: true, controller: _confirmPasswordController),
          SizedBox(
            height: 10,
          ),
          _buildAuthButton("Sign Up"),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint,
      {bool isPassword = false, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, bottom: 5, right: 30),
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButton(String label) {
    return ElevatedButton.icon(
      icon: const Icon(Iconsax.user_add),
      style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
      onPressed: () {
        setState(() {
          signUp();
        });
      },
      label: Text(label),
    );
  }
}
