import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController{

  TextEditingController purchaseDate = TextEditingController();
  TextEditingController invNo = TextEditingController();
  TextEditingController discountPrice = TextEditingController();
  TextEditingController SupplierName = TextEditingController();
  TextEditingController cName = TextEditingController();
  TextEditingController pName = TextEditingController();
  TextEditingController cNumber = TextEditingController();
  RxList<dynamic> itemList = [].obs;
  DateTime? dateTime;
  List<String> dropdownItems = [
    'Cash',
    'Card',
    'Check',
    'Mobile Pay',
    'Due',
  ];
  String selectedItem = "Cash";

  RxList<dynamic> supplierList=[].obs;
   Future<void> GetSupplier() async {
     supplierList.clear();
    QuerySnapshot<Map<String,dynamic>> data=
   await FirebaseFirestore.instance.collection('Supplier').get();
    for(int i=0;i<data.docs.length;i++){
      var d=data.docs[i].data();
      d['id']=data.docs[i].id;
      supplierList.add(d);
    }
  }
  RxInt sTotal=0.obs;
   void subTotal(){
      sTotal.value=0;
     for(int i=0;i<itemList.length;i++){
       sTotal=sTotal+int.parse(itemList[i]['totalAmt'].toString());
     }
   }
   int discount=0;
  RxDouble total = 0.0.obs;
   void getDiscount(){
     if(discount >= 1){
       double b=sTotal* discount / 100;
       total.value = sTotal.value - b;
     }

   }
   RxList purchaseList=[].obs;
   getPurchase() async {
     QuerySnapshot<Map<String,dynamic>>pDetails= await
     FirebaseFirestore.instance.collection('purchaseDetails').get();

     for(int i=0;i<pDetails.docs.length;i++){
       purchaseList.add(pDetails.docs[i].data());
     }
   }
}