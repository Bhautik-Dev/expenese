import 'package:expenese/controller/purchese_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class PurchaseList extends StatefulWidget {
  const PurchaseList({super.key});

  @override
  State<PurchaseList> createState() => _PurchaseListState();
}

class _PurchaseListState extends State<PurchaseList> {
  PurchaseController purchaseController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500)).then((value){
      purchaseController.getPurchase();
    }  );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: () { Navigator.pop(context); },),
        backgroundColor: Colors.white,
        title: Text(
          "Purchase List",
          style: TextStyle(
              color: Colors.black,
              fontSize: 19
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount:purchaseController.purchaseList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {

                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow:[BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        spreadRadius: 2,
                      )]
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(purchaseController.purchaseList[index]['name']??'')),
                          Text(purchaseController.purchaseList[index]['inv']??'')
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(7)),
                            child: Text(
                              "Paid",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),

                          Expanded(
                            child: Text(
                              purchaseController.purchaseList[index]['date']??'',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Total : \$${purchaseController.purchaseList[index]['total']}",
                              style: TextStyle(color: Colors.grey)),
                          // Text("2980.0", style: TextStyle(color: Colors.grey))
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.print,
                                color: Colors.grey,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.ios_share_outlined,
                                color: Colors.grey,
                              )),
                          IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.grey,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(height: 30,);
            },
          )
      ),
    );
  }
}
