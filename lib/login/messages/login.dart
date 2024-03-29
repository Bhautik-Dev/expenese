

import 'package:expenese/controller/user_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';



class LoginChat extends StatefulWidget {

   const LoginChat({super.key});

  @override
  State<LoginChat> createState() => _LoginChatState();
}

class _LoginChatState extends State<LoginChat> {
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black45 ,
        centerTitle: true,
        title: userController.text(data: "LOG IN", style: TextStyle(color: Colors.black)),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            userController.textfield(
              keyboardType: TextInputType.number,
              controller: userController.phoneController,
              hintText: "Phone Number",
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            // InkWell(
            //   onTap: () {
            //
            //   },
            //   child: Container(
            //     padding: EdgeInsets.all(20),
            //     child: userController.text(data: "Login"),
            //     decoration: BoxDecoration(
            //       color: Colors.black38,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            // ),
            TextButton(onPressed: (){
              userController.getOtp();

            }, child: Text("Get Otp"))
          ],
        ),
      ),
    );
  }
}
