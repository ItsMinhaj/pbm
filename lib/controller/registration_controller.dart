import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbm/views/home/homepage.dart';

import '../model/user_model.dart';
import '../widgets/error_dialog.dart';

class RegistrationController extends GetxController {
  final imagePath = "".obs;
  final isLoading = false.obs;

  Future<void> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  // Upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("profilePics")
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> registerUser(
      String email, String password, String imagePath) async {
    isLoading.value = true;
    try {

      if(imagePath.isEmpty){
        errorShowDialog("Image or other field may empty");
        isLoading.value = false;
      }else{


        print("Register method is called");
        final user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl = await _uploadToStorage(File(imagePath.toString()));

        FirebaseFirestore fireStore = FirebaseFirestore.instance;
        await fireStore.collection("users").doc(user.user!.email).set(UserModel(
            email: email, userId: user.user!.uid, profilePhoto: downloadUrl)
            .toMap());
        isLoading.value = false;


        Get.snackbar("", "Registration has been successful",
            colorText: Colors.white);

        Get.off(const HomeScreen());
      }


    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        await errorShowDialog("Email Already In Use");
      } else if (e.code == "weak-password") {
        await errorShowDialog("Weak Password");
      } else if (e.code == "invalid-email") {
        await errorShowDialog("Invalid Email");
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;

      await errorShowDialog(e.toString());
    }
  }
}