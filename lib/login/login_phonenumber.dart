import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import 'otp.dart';

class LoginPhoneNumber extends StatefulWidget {
  const LoginPhoneNumber({super.key});

  @override
  State<LoginPhoneNumber> createState() => _LoginPhoneNumberState();
}

class _LoginPhoneNumberState extends State<LoginPhoneNumber> {
  AuthController authController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.phoneNumberController.clear();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Phone Number Login',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter your phone number',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Phone Number";
                    } else if (value.length < 10) {
                      return "Please Check Your Phone Number";
                    }
                  },
                  controller: authController.phoneNumberController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    counterText: "",
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpPage(),
                        ));
                  }
                  authController.getOtp(context: context);
                },
                child: Text('Get OTP'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
