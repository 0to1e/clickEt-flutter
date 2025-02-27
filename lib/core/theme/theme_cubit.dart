import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit({required bool initialTheme}) : super(initialTheme);

  void toggleTheme() async {
    final newTheme = !state;
    await saveThemePreference(newTheme);
    emit(newTheme);
  }

  Future<void> saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }
}