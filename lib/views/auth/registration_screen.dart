// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pbm/controller/registration_controller.dart';
import 'package:pbm/utils/static.dart';
import 'package:pbm/views/auth/login_screen.dart';
import 'package:pbm/views/add_name/name_screen.dart';

import '../../widgets/text_input_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  final regController = Get.put(RegistrationController());

  @override
  void initState() {
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    regController.dispose();
    super.dispose();
  }

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
              Stack(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await regController.pickImageFromGallery();
                    },
                    child: Obx(() {
                      return Ink(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                            border:
                                Border.all(color: Colors.deepPurple, width: 2)),
                        child: ClipRRect(
                          child: regController.imagePath.isNotEmpty
                              ? Image.file(
                                  File(regController.imagePath.toString()),
                                  fit: BoxFit.fill,
                                )
                              : const Icon(Icons.person,
                                  size: 42, color: Colors.white),
                        ),
                      );
                    }),
                  ),
                  const Positioned(
                      bottom: -5,
                      right: 0,
                      child: Icon(
                        Icons.camera_alt,
                        size: 24,
                        color: Colors.deepPurple,
                      ))
                ],
              ),
              const SizedBox(height: 30),
              TextInputField(controller: _emailTextController, label: "Email"),
              const SizedBox(height: 10),
              TextInputField(
                  controller: _passwordTextController,
                  label: "Password",
                  obscure: true),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => const AddName()));
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
                      "Registration",
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
                    "Already have an account?",
                    style: GoogleFonts.dmSans(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => const LoginScreen()));
                    },
                    child: Text(
                      " Login",
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
