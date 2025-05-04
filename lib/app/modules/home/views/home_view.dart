import 'package:firebasecli/app/models/addDataModel.dart';
import 'package:firebasecli/app/modules/add_document/views/add_document_view.dart';
import 'package:firebasecli/theme/app_theme_data.dart';
import 'package:firebasecli/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const TextView(text: 'Home Screen'), backgroundColor: AppThemeData.blue),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppThemeData.blue,
            foregroundColor: AppThemeData.grey25,
            onPressed: () {
              controller.nameController.value.clear();
              controller.surnameController.value.clear();
              controller.addDataModel.value = AddDataModel();
              Get.to(() => AddDocumentView());
            },
            child: const Icon(Icons.add),
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.modelDataList.isEmpty) {
              return const Center(child: TextView(text: 'No data found.'));
            }

            return ListView.builder(
              itemCount: controller.modelDataList.length,
              itemBuilder: (context, index) {
                final data = controller.modelDataList[index];
                return Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [TextView(text: 'Name: ${data.name}', maxLines: 1), TextView(text: 'Surname: ${data.surName}', maxLines: 1)],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              controller.isEdit.value = true;
                              controller.getArgument(data);
                              Get.to(() => AddDocumentView());
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              controller.deleteData(data.id ?? '');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        );
      },
    );
  }
}
