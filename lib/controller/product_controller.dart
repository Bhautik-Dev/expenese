


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenese/controller/sale_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController{

  final formKey = GlobalKey<FormState>();
  TextEditingController pName = TextEditingController();
  TextEditingController pcategory = TextEditingController();
  TextEditingController pBrand = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController pPrice = TextEditingController();
  TextEditingController mRp = TextEditingController();
  TextEditingController wPrice = TextEditingController();
  TextEditingController dPrice = TextEditingController();
  TextEditingController mfacturer = TextEditingController();
  TextEditingController sUnilts = TextEditingController();
  TextEditingController pCode = TextEditingController();

  SaleController saleController=Get.find();

  bool isLoading = false;

  RxList<dynamic> productList =[].obs;

  TextEditingController addPCategory = TextEditingController();
  List<dynamic> addPBrandsList = [];

  final ImagePicker picker = ImagePicker();

  File? imageFile;

  List<dynamic> addPCategoryList = [];

  List<dynamic> addUnitsList = [];


  Future<void>  getProduct() async {
    productList.clear();
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("Product").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      dynamic item=querySnapshot.docs[i].data();
      item['id']=querySnapshot.docs[i].id;
      item['qty'] = 1;
      item['totalAmt'] = item['pPurchase'];
      productList.add(item);

    }
  }

  Future<void> getUnits() async {
    addUnitsList.clear();
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("PUnits").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      dynamic item=querySnapshot.docs[i].data();
      item['id']=querySnapshot.docs[i].id;
     addUnitsList.add(item);
    }
  }

  Future<void> getCategory() async {
    addPCategoryList.clear();
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("PCategory").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      dynamic item=querySnapshot.docs[i].data();
      item['id']=querySnapshot.docs[i].id;
      addPCategoryList.add(item);
    }
  }

  Future<void> getBrand() async {
    addPBrandsList.clear();
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("Pbrands").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      dynamic item=querySnapshot.docs[i].data();
      item['id']=querySnapshot.docs[i].id;
      addPBrandsList.add(item);
    }
  }
}