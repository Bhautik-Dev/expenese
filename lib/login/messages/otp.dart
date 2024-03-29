import 'dart:developer';

import 'package:expenese/controller/auth_controller.dart';
import 'package:expenese/controller/user_controller.dart';
import 'package:expenese/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  UserController userController = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            userController.textfield(
              keyboardType: TextInputType.number,
              hintText: "Enter OTP",
              controller: userController.otpCntrl,
            ),
            TextButton(
                onPressed: () async {
                  userController.getVerifyOtp();
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
