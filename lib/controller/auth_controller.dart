import 'package:expenese/home.dart';
import 'package:expenese/login/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
 String tokenId="";
  getOtp({context}){
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${phoneNumberController.text}',
        verificationCompleted: (verificationCompleted){

        },
        verificationFailed: (verificationFailed){

        },
        codeSent: (verificationId,token){
          // debugPrint("verificationId${verificationId}");
          tokenId=verificationId;
          // debugPrint("token${token}");
          Get.to(Home());

        },
        codeAutoRetrievalTimeout:(codeAutoRetrievalTimeout){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Time Out")));
        });
  }
   getVerify(){
   var credential =  PhoneAuthProvider.credential(
        verificationId:tokenId,
        smsCode:otpController.text );
    FirebaseAuth.instance.signInWithCredential(credential).then((value){
      Get.offAll(const Home());
    });
  }
}