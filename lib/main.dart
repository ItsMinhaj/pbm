import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pbm/model/transaction_model.dart';
import 'package:pbm/utils/theme.dart';
import 'package:pbm/views/auth/login_screen.dart';

import 'firebase_options.dart';

//late Box transactionBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox("transactionBox");
  Hive.registerAdapter(TransactionModelAdapter());

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
