import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pbm/views/auth/login_screen.dart';
import 'package:pbm/views/home/homepage.dart';

import '../widgets/error_dialog.dart';

class LoginController extends GetxController{
  final isLoading = false.obs;
  late Rx<User?> _user;

  Future<void> loginUser(String? email, String? password) async {
    isLoading.value = true;
    try {
      if (email != null && password != null) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

      }
      Get.off(const HomeScreen());
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        isLoading.value = false;
        await errorShowDialog("Error: User Not Found");

      } else if (e.code == "wrong-password") {
        isLoading.value = false;
        await errorShowDialog("Error: Wrong Password");

      } else {
        isLoading.value = false;
        await errorShowDialog(e.code);

      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      await errorShowDialog(e.toString());

    }
  }


  // For managing user session
  @override
  void onReady() {
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialScreen);
    super.onReady();
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.off(()=>const LoginScreen());
    } else {
      Get.off(()=>const HomeScreen());
    }
  }
}
