import 'package:flutter/material.dart';
import 'package:my_ecom_app/features/product/presentation/screens/authentication/auth_screen.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/btm_nav_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
          final session = snapshot.hasData ? snapshot.data!.session : null;
          if (session != null) {
            return const BtmNavBar();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
