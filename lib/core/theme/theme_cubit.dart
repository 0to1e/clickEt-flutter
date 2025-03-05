import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:light_sensor/light_sensor.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit({required bool initialTheme}) : super(initialTheme) {
    _startListeningToLightSensor();
  }

  void toggleTheme() async {
    final newTheme = !state;
    await saveThemePreference(newTheme);
    emit(newTheme);
  }

  Future<void> saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  void _startListeningToLightSensor() {
    LightSensor.luxStream().listen((lux) {
     
      bool newTheme = lux < 50; 

      if (newTheme != state) {
        emit(newTheme);
        saveThemePreference(newTheme);
      }
    });
  }
}
