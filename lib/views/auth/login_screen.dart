import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pbm/controller/login_controller.dart';
import 'package:pbm/services/database_helper.dart';
import 'package:pbm/utils/validating_rules.dart';
import 'package:pbm/views/add_name/name_screen.dart';
import 'package:pbm/views/auth/registration_screen.dart';
import 'package:pbm/views/home/homepage.dart';

import '../../utils/static.dart';
import '../../widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  final loginController = Get.put(LoginController());

  final _formkey = GlobalKey<FormState>();

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
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    TextInputField(
                        controller: _emailTextController, label: "Email",
                      validator: ValidationRules.email),
                   const  SizedBox(height: 10),
                    TextInputField(
                        controller: _passwordTextController,
                        label: "Password",
                        validator: ValidationRules.password,
                        obscure: true),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                       if(_formkey.currentState!.validate()){
                         _formkey.currentState?.save();
                         loginController.loginUser(_emailTextController.text,
                             _passwordTextController.text);
                       }
                      },
                      borderRadius: BorderRadius.circular(15.0),
                      child: Obx(

                       () {
                          return Ink(
                            width: 200,
                            height: 48,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Center(
                              child: loginController.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.white))
                                  : Text(
                                      "Login",
                                      style: GoogleFonts.dmSans(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                            ),
                          );
                        }
                      ),
                    ),
                  ],
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
                          builder: (_) => const AddName()));
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
