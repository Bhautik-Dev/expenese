import 'package:expenese/controller/user_controller.dart';
import 'package:expenese/expense.dart';
import 'package:expenese/home.dart';
import 'package:expenese/login/login_phonenumber.dart';
import 'package:expenese/login/messages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'login/messages/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  final getStorage=GetStorage();
  UserController userController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircleAvatar(
          maxRadius: 60,
          child: Image.asset("assets/image/messenger2.png"))),


    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //
  //   Future.delayed(Duration(seconds: 2),
  //     (){
  //
  //     if(getStorage.read('isLogin')??false){
  //       userController.myDetails = getStorage.read("deatails");
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePageMSG(),));
  //     }else{
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginChat(),));
  //     }
  //
  //   }
  //   );
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2));
    (){
      Get.to(Home());
    };
  }

}
