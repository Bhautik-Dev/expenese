import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SaleController extends GetxController {
  DateTime? dateTime;
  TextEditingController salesDate = TextEditingController();
  TextEditingController discountPrice = TextEditingController();
  TextEditingController invNo=TextEditingController();
  RxBool isLoading=false.obs;

  List<String> dropdownItems = [
    'Cash',
    'Card',
    'Check',
    'Mobile Pay',
    'Due',
  ];
  String selectedItem = "Cash";

  RxList<dynamic> itemList = [].obs;
  RxList<dynamic> salesList = [].obs;

  RxInt subTotal = 0.obs;

  void updateSubTotalPrice() {
    subTotal.value = 0;
    for (int i = 0; i < itemList.length; i++) {
      subTotal = subTotal + int.parse(itemList[i]['totalAmt'].toString());
    }
    calculateDiscount();
  }

  RxDouble total = 0.0.obs;
  int discountPer = 0;

  calculateDiscount() {
    if (discountPer >= 1) {
      double d = subTotal * discountPer / 100;
      total.value = subTotal.value - d;
    }
  }


  Future<void> getSales() async {
    salesList.clear();
    isLoading.value=true;
    QuerySnapshot<Map<String, dynamic>> list =
    await FirebaseFirestore.instance.collection("Sales").get();
    for (int i = 0; i < list.docs.length; i++) {
      dynamic item = list.docs[i].data();
      item['id'] = list.docs[i].id;
      salesList.add(item);
    }
    isLoading.value=false;

  }

}
