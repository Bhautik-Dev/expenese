import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{

  TextEditingController addCategory = TextEditingController();
  List<dynamic> addCategoryList = [];

  Future<void> getCategory() async {
    addCategoryList.clear();
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("category").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      dynamic item=querySnapshot.docs[i].data();
      item['id']=querySnapshot.docs[i].id;
      addCategoryList.add(item);
    }
  }
}