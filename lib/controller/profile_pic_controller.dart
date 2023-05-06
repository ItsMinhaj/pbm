

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfilePicController extends GetxController{

final imgUrl = "".obs;
 Future<String>getProfileImage() async{
   FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot userDocs = await firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.email).get();
  imgUrl.value =  userDocs["profilePhoto"];
   return imgUrl.value;
 }


 @override
  void onInit() async{
   await getProfileImage();
    super.onInit();
  }
}