import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenese/home.dart';
import 'package:expenese/login/messages/home.dart';
import 'package:expenese/login/messages/otp.dart';
import 'package:expenese/login/messages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../login/otp.dart';

class UserController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpCntrl = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String verificationId = "";
  Map<String, dynamic> myDetails = {};
  RxBool isShowSendButton = false.obs;

  Widget textfield(
      {TextEditingController? controller,
        TextInputType? keyboardType,

      String? hintText,
      void Function()? onTap}) {
    return TextFormField(
      onTap: onTap,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  Widget text({data, TextStyle? style}) {
    return Text(
      data,
      style: style,
    );
  }

  getOtp() {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${phoneController.text}",
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException firebaseAuthException) {},
        codeSent: (id, code) {
          verificationId = id;
          Get.to(OTP());
        },
        codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {});
  }

  getVerifyOtp() {
    var credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCntrl.text);
    FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("Registration")
          .where("pNumber", isEqualTo: phoneController.text)
          .get();
      if(data.docs.isNotEmpty){
        Map<String, dynamic> map = data.docs[0].data();
        map['id'] = data.docs[0].id;
        myDetails = map;
        box.write('isLogin', true);
        box.write("deatails", myDetails);
        Get.to(HomePageMSG());}else{
      Get.to(ProfilePage());}
    });
  }

  TextEditingController name = TextEditingController();

  userRegistration() {
    FirebaseFirestore.instance
        .collection('Registration')
        .doc()
        .set({'name': name.text, 'pNumber': phoneController.text,'istyping':false}).then(
            (value) async {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("Registration")
          .where("pNumber", isEqualTo: phoneController.text)
          .get();
      if (data.docs.isNotEmpty) {
        Map<String, dynamic> map = data.docs[0].data();
        map['id'] = data.docs[0].id;
        myDetails = map;
        box.write('isLogin', true);
        box.write("deatails", myDetails);
        Get.to(HomePageMSG());
      }
    });
  }


  final box = GetStorage();
  RxList<dynamic> users = [].obs;

  getUserData() async {
    users.clear();
    QuerySnapshot<Map<String, dynamic>> datah =
        await FirebaseFirestore.instance.collection("Registration").get();
    for (int i = 0; i < datah.docs.length; i++) {
      Map map = datah.docs[i].data();
      map['id'] = datah.docs[i].id;
      users.add(map);
    }
  }

  dynamic groupChatId;

  idData(users) {
    if (myDetails['id'].hashCode <= users.hashCode) {
      groupChatId = '${myDetails['id']}-$users';
    } else {
      groupChatId = '$users-${myDetails['id']}';
    }
  }

  getTyping({peerId}){
    FirebaseFirestore.instance.collection('MSG').doc(groupChatId).set({
      "${myDetails['id']}-isTyping":false,
      "${peerId}-isTyping":false,

    });
  }

}
