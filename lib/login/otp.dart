import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key,});

  @override
  State<OtpPage> createState() => _OtpPageState();
}


class _OtpPageState extends State<OtpPage> {
  // TextEditingController _phoneNumberController = TextEditingController();
  AuthController authController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.otpController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('OTP',style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextField(
            //   controller: _phoneNumberController,
            //   keyboardType: TextInputType.phone,
            //   decoration: InputDecoration(
            //     labelText: 'Phone Number',
            //   ),
            // ),
            SizedBox(height: 16.0),
            TextField(
              controller: authController.otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'OTP',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                authController.getVerify();
                // Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(),));
              },
              child: Text('Verify OTP'),
            ),
            TextButton(onPressed: () {

            }, child: Text("Resend OTP"))
          ],
        ),
      ),
    );
  }
}
