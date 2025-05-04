import 'package:firebasecli/app/modules/home/controllers/home_controller.dart';
import 'package:firebasecli/theme/app_theme_data.dart';
import 'package:firebasecli/widgets/global_widget.dart';
import 'package:firebasecli/widgets/round_shape_button.dart';
import 'package:firebasecli/widgets/text_field.dart';
import 'package:firebasecli/widgets/text_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_document_controller.dart';

class AddDocumentView extends StatelessWidget {
  AddDocumentView({super.key});

  final formKey = GlobalKey<FormState>();
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextView(text: 'Add Data'), backgroundColor: AppThemeData.blue),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFieldWidget(
                title: "User Name".tr,
                hintText: "User Name".tr,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
                controller: controller.nameController.value,
                onPress: () {},
              ),
              spaceH(),
              Obx(
                () => TextFieldWidget(
                  title: "SurName".tr,
                  hintText: "Enter SurName".tr,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "SurName is required";
                    }
                    return null;
                  },
                  controller: controller.surnameController.value,
                  onPress: () {},
                ),
              ),
              spaceH(),
              Obx(
                () => RoundShapeButton(
                  title: controller.isEdit.value ? "Update" : "Add",
                  buttonColor: AppThemeData.primary300,
                  buttonTextColor: AppThemeData.grey50,
                  onTap: () {
                    final isValid = formKey.currentState?.validate() ?? false;
                    if (isValid) {
                      controller.isEdit.value ? controller.updateData() : controller.addData();
                    }
                  },
                  isLoading: controller.isAdd.value,
                  size: const Size(358, 58),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
