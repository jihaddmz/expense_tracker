import 'package:expense_tracker/feature_expense/data/local/sqlite_database.dart';
import 'package:expense_tracker/feature_expense/presentation/screen_home.dart';
import 'package:expense_tracker/core/config/color.dart';
import 'package:expense_tracker/core/helpers/helper_sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqliteDatabase.createDatabase();
  await HelperSharedPref.setInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set the status bar color to white
      statusBarIconBrightness:
          Brightness.dark, // Set the status bar icons to dark
    ));

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: colorWhite,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      darkTheme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      themeMode: ThemeMode.system, // Auto switch based on system mode
      home: const SafeArea(
          child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 20),
          child: ScreenHome(),
        ),
      )),
    );
  }
}
