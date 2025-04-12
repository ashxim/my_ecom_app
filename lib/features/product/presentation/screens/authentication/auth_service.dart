import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> signInWithEmailPass(
      String email, String password) async {
    return await _supabase.auth
        .signInWithPassword(password: password, email: email);
  }

  Future<AuthResponse> signUpWithEmailPass(
      String email, String password) async {
    return await _supabase.auth.signUp(
      password: password,
      email: email,
    );
  }

  Future<bool> signInWithGoogle() async {
    return await _supabase.auth.signInWithOAuth(OAuthProvider.google);
  }

  Future<bool> signInWithFacebook() async {
    return await _supabase.auth.signInWithOAuth(OAuthProvider.facebook);
  }

  Future<void> signOut() async {
    return await _supabase.auth.signOut();
  }

  String? getUserEmail() {
    final Session = _supabase.auth.currentSession;
    final user = Session?.user;
    return user?.email;
  }

  String? getUserName() {
    // Replace with your logic to fetch the user's name
    return "Sample User";
  }
}
