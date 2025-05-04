import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasecli/app/models/userModel.dart';
import 'package:firebasecli/app/routes/app_pages.dart';
import 'package:firebasecli/utils/fire_store_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SingUpController extends GetxController {
  RxBool isPasswordVisible = true.obs;
  RxBool isLoading = false.obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController = TextEditingController().obs;
  final Rx<UserModel> userModel = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  singUp() async {
    isLoading.value =true;
    String email = emailController.value.text;
    String password = passwordController.value.text;

    await singUpEmailWithPass(email, password).then((value) async {
      log('===========> singUpEmailWithPass value ${value}');
      userModel.value.id = value!.user!.uid;
      userModel.value.email = email;
      userModel.value.createdAt = Timestamp.now();
      userModel.value.active = true;
      log('===========> uid value ${value!.user!.uid}');

      await FireStoreUtils.addUser(userModel.value).then((value) {
        if (value == true) {
          isLoading.value = false;
          Get.offAllNamed(Routes.LOGIN);
        }
      });
      log('===========> value ${value}');
    });
  }

  Future<UserCredential?> singUpEmailWithPass(email, password) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      log('============> email already exists${e}');
    }
    return null;
  }
}
