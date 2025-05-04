import 'package:firebasecli/widgets/text_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return  GetBuilder(
      init: SplashScreenController(),
        builder: (controller){
      return Scaffold(
        body: const Center(
          child:  TextView(text: 'Splash Screen',fontWeight: FontWeight.w500,),
        ),
      );
    });
  }
}
