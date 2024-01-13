
import 'package:flutter/material.dart';
import 'package:school_management_app/widgets/login_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Management App',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor:  Color.fromARGB(255, 104, 66, 111),
          brightness: Brightness.dark,
          surface: Color.fromARGB(255, 95, 25, 164),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 55, 46, 65),
      ),
      home: LoginScreen(),
    );
  }
}


