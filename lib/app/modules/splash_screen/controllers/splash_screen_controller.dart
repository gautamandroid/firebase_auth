import 'dart:async';
import 'dart:developer';

import 'package:firebasecli/app/routes/app_pages.dart';
import 'package:firebasecli/constant/constant.dart';
import 'package:firebasecli/utils/fire_store_utils.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  final count = 0.obs;

  @override
  void onInit() {
    Timer(Duration(seconds: 3), () {
      redirectScreen();
    });

    super.onInit();
  }

  redirectScreen() async {

    log('=========> call redirect screen');

    bool isLogin = await FireStoreUtils.isLogin();
    if (isLogin == true) {
      Constant.userModel = await FireStoreUtils.getUserProfile(FireStoreUtils.getCurrentUserId());
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.SINGUP);
    }
  }
}
