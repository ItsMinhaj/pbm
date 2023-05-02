import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pbm/utils/theme.dart';
import 'package:pbm/views/auth/login_screen.dart';
import 'package:pbm/views/auth/registration_screen.dart';
import 'package:pbm/views/home/homepage.dart';
import 'package:pbm/views/add_name/name_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PBM',
      theme: myTheme,
      home: const LoginScreen(),
    );
  }
}
