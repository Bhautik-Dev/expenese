import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenese/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
UserController userController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "New Add",
          style:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.green[900]),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green[900],
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(children: [
          TextFormField(
            controller: userController.name,
            decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(
            height: 15,
          ),
        ]),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
        userController.userRegistration();
        },
        child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Add",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ],
            )),
      ),
    );
  }
}
