import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/parties_controller.dart';

class PartiesAdd extends StatefulWidget {
  const PartiesAdd({super.key});

  @override
  State<PartiesAdd> createState() => _PartiesAddState();
}

class _PartiesAddState extends State<PartiesAdd> {

PartiesController partiesController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
       Navigator.pop(context);
          },
        ),
        title: Text(
          "Parties Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: partiesController.cName,
              decoration: InputDecoration(
                  hintText: "Customer Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: partiesController.pName,
              decoration: InputDecoration(
                  hintText: "Parties Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: partiesController.cNumber,
              decoration: InputDecoration(
                  hintText: "Contact Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  counterText: ""),
              maxLength: 10,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                FirebaseFirestore.instance
                    .collection("PartiesDetails")
                    .doc()
                    .set({
                  'CName': partiesController.cName.text,
                  'PName': partiesController.pName.text,
                  'CNumber': partiesController.cNumber.text
                });
                Navigator.pop(context);
                setState(() {
                  partiesController.cName.clear();
                  partiesController.pName.clear();
                  partiesController.cNumber.clear();
                });
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  "Add",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
