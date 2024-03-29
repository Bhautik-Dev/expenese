import 'package:expenese/purchase/add_purchase.dart';
import 'package:expenese/purchase/add_supplier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/purchese_controller.dart';
import '../home.dart';

class PurcheseHome extends StatefulWidget {
  final dynamic model;
   PurcheseHome({super.key,this.model});

  @override
  State<PurcheseHome> createState() => _PurcheseHomeState();
}

class _PurcheseHomeState extends State<PurcheseHome> {
  PurchaseController purchaseController=Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500)).then((value){
      purchaseController.GetSupplier();
    }  );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ));
          },
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddSupplier(),));
          }, icon: Icon(Icons.add,color: Colors.black,))
        ],
        backgroundColor: Colors.white,
        title: Text(
          "Choose a Supplier",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Obx(() => ListView.separated(
                itemCount:purchaseController.supplierList.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Row(
                      children: [
                        CircleAvatar(),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                purchaseController.supplierList[index]['CName'],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(purchaseController.supplierList[index]['PName'])
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddPurchase(model: purchaseController.supplierList[index]),));
                            },
                            icon: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
              )),
            )
          ],
        ),
      ),
    );
  }
}
