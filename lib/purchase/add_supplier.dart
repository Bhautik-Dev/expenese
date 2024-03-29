import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenese/controller/purchese_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSupplier extends StatefulWidget {
  const AddSupplier({super.key});

  @override
  State<AddSupplier> createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {
  PurchaseController purchaseController=Get.find();
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
          "Add Supplier",
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
              controller: purchaseController.cName,
              decoration: InputDecoration(
                  hintText: "Customer Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: purchaseController.pName,
              decoration: InputDecoration(
                  hintText: "Parties Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: purchaseController.cNumber,
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
                    .collection("Supplier")
                    .doc()
                    .set({
                  'CName': purchaseController.cName.text,
                  'PName': purchaseController.pName.text,
                  'CNumber': purchaseController.cNumber.text
                });
                purchaseController.GetSupplier();
                Navigator.pop(context);
                setState(() {
                  purchaseController.cName.clear();
                  purchaseController.pName.clear();
                  purchaseController.cNumber.clear();
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
