import 'package:ClickEt/app/app.dart';
import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/network/hive_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  // await HiveService().clearStudentBox();

  await initDependencies();

  runApp(
    const App(),
  );
}
