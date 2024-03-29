import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenese/controller/product_controller.dart';
import 'package:expenese/product/p_brands.dart';
import 'package:expenese/product/p_category.dart';
import 'package:expenese/product/p_home.dart';
import 'package:expenese/product/p_units.dart';
import 'package:expenese/widget/qr_code_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../vars.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  ProductController productController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Add New Product",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: productController.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: productController.pName,
                  // enabled: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Product name";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      // labelText: "Expense For",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Smart Watch",
                      label: Text("Product name"),
                      hintStyle: TextStyle(color: Colors.black38),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                ),
                SizedBox(
                  height: 18,
                ),
                InkWell(
                  onTap: () async {
                    var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pcategory(),
                        ));

                    if (result != null) {
                      productController.pcategory.text = result;
                    }
                  },
                  child: TextField(
                    controller: productController.pcategory,
                    enabled: false,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        hintText: "Select Product Category",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                InkWell(
                  onTap: () async {
                    var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pbrands(),
                        ));

                    if (result != null) {
                      productController.pBrand.text = result;
                    }
                  },
                  child: TextField(
                    controller: productController.pBrand,
                    enabled: false,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        hintText: "Select Brands",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        controller: productController.pCode,
                        // enabled: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Product code";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            // labelText: "Expense For",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Enter Product Code",
                            label: Text("Product Code"),
                            hintStyle: TextStyle(color: Colors.black38),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const QrCodePage();
                            },
                          ));
                        },
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Colors.black38)),
                          child:
                              Image.asset("assets/image/scanning_9063154.png"),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Expanded(
                        child: widgetTextField(
                            controller: productController.stock,
                            hintText: "20",
                            labelText: "Stock")),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PUnits(),
                              ));

                          if (result != null) {
                            productController.sUnilts.text = result;
                          }
                        },
                        child: TextField(
                          controller: productController.sUnilts,
                          enabled: false,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              hintText: "Select Unilts",
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)))),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Expanded(
                        child: widgetTextField(
                            controller: productController.pPrice,
                            hintText: "\$ 300.90",
                            labelText: "Purchase Price")),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                        child: widgetTextField(
                            controller: productController.mRp,
                            hintText: "\$ 234.09",
                            labelText: "MRP")),
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Expanded(
                        child: widgetTextField(
                            controller: productController.wPrice,
                            hintText: "\$ 155",
                            labelText: "WholeSale Price")),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                        child: widgetTextField(
                            controller: productController.dPrice,
                            hintText: "\$ 130",
                            labelText: "Dealer Price")),
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                widgetTextField(
                    controller: productController.mfacturer,
                    hintText: "Apple",
                    labelText: "Manufacturer"),
                SizedBox(
                  height: 18,
                ),
                InkWell(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => Dialog(
                        insetPadding: EdgeInsets.all(70),
                        child: Container(
                          // padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/image/diaphragm.png",
                                height: 70,
                                width: 60,
                              ),
                              InkWell(
                                onTap: () {
                                  openGallery();
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  "assets/image/gallery.png",
                                  height: 70,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      productController.imageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(60.0),
                              child: Container(
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: CircleAvatar(
                                  radius: 60,
                                  child: Image.file(productController.imageFile! as File),
                                ),
                              ),
                            )
                          : CircleAvatar(
                              child: Image.asset(
                                "assets/image/add-image_5007662.png",
                              ),
                              radius: 60,
                            ),
                      Positioned(
                          bottom: 9,
                          child: Container(
                              height: 30,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey),
                              child: Image.asset(
                                "assets/image/camera_685655.png",
                              )))
                    ],
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                InkWell(
                  onTap: () async {
                    if (productController.formKey.currentState!.validate()) {
                      productController.isLoading = true;
                      setState(() {

                      });
                      final storageRef = FirebaseStorage.instance.ref();
                      final mountainsRef = storageRef.child("${DateTime.now().millisecond}.jpg");
                      File file = File(productController.imageFile!.path);
                      await mountainsRef.putFile(file);
                      String profilePath=await mountainsRef.getDownloadURL();
                      // product['img']=profilePath;

                       product = {
                        'pName': productController.pName.text,
                        'pCategory': productController.pcategory.text,
                        'pBrand': productController.pBrand.text,
                        'stock': productController.stock.text,
                         'code':productController.pCode.text,
                        'pUnilts': productController.sUnilts.text,
                        'pPurchase': productController.pPrice.text,
                        'pMRP': productController.mRp.text,
                        'pWholeSale': productController.wPrice.text,
                        'pDealer': productController.dPrice.text,
                        'pManuFacturer': productController.mfacturer.text,
                        'img': profilePath,
                      };

                      FirebaseFirestore.instance
                          .collection("Product")
                          .add(product).then((value){
                        productController.isLoading = false;
                        setState(() {

                        });
                      });
                      // getProduct();
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: Center(
                          child:
                          productController.isLoading == true ? const CircularProgressIndicator(color: Colors.white,):
                          Text(
                            "Save and Publish",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetTextField(
      {required TextEditingController controller,
      String? hintText,
      String? labelText}) {
    return TextFormField(
      controller: controller,
      // enabled: false,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter Product code";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          // labelText: "Expense For",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          labelText: labelText,
          // label: Text("Product Code"),
          hintStyle: TextStyle(color: Colors.black38),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)))),
    );
  }

  openGallery() async {
    final XFile? image = await productController.picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      debugPrint(image.path);
      productController.imageFile = File(image.path);
      setState(() {});
    }
  }
}
