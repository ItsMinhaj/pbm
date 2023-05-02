import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pbm/views/auth/registration_screen.dart';
import 'package:pbm/views/home/homepage.dart';

import '../../utils/static.dart';
import '../../widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
                child: const ClipRRect(
                  child: Icon(Icons.person, size: 32),
                ),
              ),
              const SizedBox(height: 30),
              const TextInputField(label: "Email"),
              const SizedBox(height: 10),
              const TextInputField(label: "Password", obscure: true),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
                borderRadius: BorderRadius.circular(15.0),
                child: Ink(
                  width: 200,
                  height: 48,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Center(
                    child: Text(
                      "Login",
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.dmSans(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => const RegistrationScreen()));
                    },
                    child: Text(
                      " Registration",
                      style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
