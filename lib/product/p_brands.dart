import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/product_controller.dart';

class Pbrands extends StatefulWidget {
  const Pbrands({super.key});

  @override
  State<Pbrands> createState() => _CategoryState();
}

class _CategoryState extends State<Pbrands> {
  ProductController productController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.getBrand();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Brands",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(right: 25, left: 10),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)))),
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Add Brands'),
                            content: TextFormField(
                              controller: productController.addPCategory,
                              decoration:
                              InputDecoration(hintText: "Add Brands"),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("Pbrands")
                                      .doc()
                                      .set({
                                    'Pbrands': productController.addPCategory.text,
                                  });
                                  productController.addPCategory.clear();
                                  productController.getBrand();
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: const Text('Add'),
                              ),
                            ],
                          ));
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: productController.addPBrandsList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            productController.addPBrandsList[index]['Pbrands'],
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context,productController.addPBrandsList[index]['Pbrands']);
                          },
                          child: Container(
                            height: 40,
                            width: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green[50],
                            ),
                            child: Center(
                                child: Text(
                                  "Select",
                                  style: TextStyle(color: Colors.black, fontSize: 20),
                                )),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('Pbrands')
                                  .doc(productController.addPBrandsList[index]['id'])
                                  .delete();
                              productController.getBrand();
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          ),
        ]),
      ),
    );
  }
}
