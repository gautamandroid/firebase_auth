import 'package:firebasecli/app/models/addDataModel.dart';
import 'package:firebasecli/constant/constant.dart';
import 'package:firebasecli/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> surnameController = TextEditingController().obs;
  Rx<bool> isAdd = false.obs;
  Rx<bool> isEdit = false.obs;
  Rx<bool> isLoading = false.obs;

  Rx<AddDataModel> addDataModel = AddDataModel().obs;
  RxList<AddDataModel> modelDataList = <AddDataModel>[].obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    modelDataList.clear();
    List<AddDataModel> dataList = await FireStoreUtils.getDataList();
    modelDataList.addAll(dataList);
    isLoading.value = false;
  }

  getArgument(AddDataModel addDataModels) {
    addDataModel.value = AddDataModel(id: addDataModels.id, name: addDataModels.name, surName: addDataModels.surName);

    nameController.value.text = addDataModels.name ?? '';
    surnameController.value.text = addDataModels.surName ?? '';
  }

  addData() async {
    isAdd.value = true;
    addDataModel.value.id = Constant.getUuid();
    addDataModel.value.name = nameController.value.text;
    addDataModel.value.surName = surnameController.value.text;
    await FireStoreUtils.addDocument(addDataModel.value);
    isAdd.value = false;
    getData();
    Get.back();
  }

  updateData() async {
    isAdd.value = true;
    // addDataModel.value.id = Constant.getUuid();
    addDataModel.value.name = nameController.value.text;
    addDataModel.value.surName = surnameController.value.text;
    await FireStoreUtils.addUpdateDocument(addDataModel.value);
    isAdd.value = false;
    getData();
    Get.back();
  }

  deleteData(String docId) async {
    isLoading.value = true;
    await FireStoreUtils.deleteDocument(docId);
    modelDataList.removeWhere((element) => element.id == docId);
    isLoading.value = false;
  }
}
