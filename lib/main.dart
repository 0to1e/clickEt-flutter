import 'package:ClickEt/app/app.dart';
import 'package:ClickEt/app/di/di.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    const App(),
  );
}
