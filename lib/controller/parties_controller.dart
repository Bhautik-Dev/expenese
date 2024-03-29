import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PartiesController extends GetxController{

  TextEditingController cName = TextEditingController();
  TextEditingController pName = TextEditingController();
  TextEditingController cNumber = TextEditingController();

  RxList<Map<String, dynamic>> partyList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> partyDetailsList = <Map<String, dynamic>>[].obs;
  

  RxBool isLoading=false.obs;
  Future<void> getParty() async {
    partyList.clear();
    isLoading.value=true;
    QuerySnapshot<Map<String, dynamic>> list =
    await FirebaseFirestore.instance.collection("PartiesDetails").get();
    for (int i = 0; i < list.docs.length; i++) {
      dynamic item = list.docs[i].data();
      item['id'] = list.docs[i].id;
      partyList.add(item);
    }
    isLoading.value=false;

  }
  RxBool isDetailsLoading=false.obs;
  getPartiesDetails({id}) async {
    partyDetailsList.clear();
    isDetailsLoading.value=true;
    QuerySnapshot<Map<String,dynamic>> pDetails =
    await FirebaseFirestore.instance.collection("Sales").get();
    for(int i=0;i< pDetails.docs.length;i++){
      if(id == pDetails.docs[i]['partyId']){
        partyDetailsList.add(pDetails.docs[i].data(),);
      }
    }
    isDetailsLoading.value=false;
  }
}