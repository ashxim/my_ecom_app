import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPreferences {
  static const _keyOnboardingCompleted = 'onboarding_completed';

  static Future<bool> getOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingCompleted) ?? false;
  }

  static Future<void> setOnboardingCompleted(bool completed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingCompleted, completed);
  }
}
