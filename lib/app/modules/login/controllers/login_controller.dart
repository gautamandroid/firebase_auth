import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasecli/app/routes/app_pages.dart';
import 'package:firebasecli/constant/constant.dart';
import 'package:firebasecli/utils/fire_store_utils.dart';
import 'package:firebasecli/widgets/show_toast_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isPasswordVisible = true.obs;
  RxBool isLoading = false.obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController = TextEditingController().obs;




  @override
  void onInit() {
    super.onInit();
  }

  emailSingIn() async {
    String email = emailController.value.text;
    String passWord = passwordController.value.text;

    try {
      singInWithEmailAndPassword(email, passWord).then((value) async {
        await FireStoreUtils.getUserProfile(FireStoreUtils.getCurrentUserId()).then((value) async {
          if (value != null) {
            if (value.active == true) {
              Constant.isLogin = await FireStoreUtils.isLogin();
              Get.offAllNamed(Routes.LOGIN);
            } else {
              FirebaseAuth.instance.signOut();
              ShowToastDialog.toast('Please Contact Administer');
            }
          } else {
            ShowToastDialog.toast('Email and Password is Invalid');
          }
        });
      });
    } catch (e) {
      log('====> error of login $e');
      ShowToastDialog.toast('Email & Password invalid');
    }
  }

  Future<UserCredential?> singInWithEmailAndPassword(email, passWord) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: passWord).catchError((error) {
      log('======>Error ${error}');
    });
  }
}
