import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenese/controller/product_controller.dart';
import 'package:expenese/controller/sale_controller.dart';
import 'package:expenese/home.dart';
import 'package:expenese/product/add_new_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../vars.dart';

class ProductHome extends StatefulWidget {
  const ProductHome({super.key});


  @override
  State<ProductHome> createState() => _ProductHomeState();
}

class _ProductHomeState extends State<ProductHome> {
  ProductController productController=Get.find();
  SaleController saleController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
          "Product List",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Obx(() => ListView.separated(
        itemCount:productController.productList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
            saleController.itemList.add(productController.productList[index]);
            saleController.updateSubTotalPrice();
            Get.back(result: productController.productList[index]);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage:
                        NetworkImage("${productController.productList[index]['img']??''}"),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(productController.productList[index]['pName']??''),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Stock : "),
                                Text(productController.productList[index]['stock']??''),
                              ],
                            )
                          ],
                        ),
                      ),
                      Text(productController.productList[index]['pPurchase']??''),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(indent: 10,endIndent: 10,);
        },
      )),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: InkWell(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddProduct(),
                )).then((value){
              productController.getProduct();
            });
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            child: Center(
                child: Text(
                  "Add New Product +",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white),
                )),
          ),
        ),
      ),
    );
  }
}
