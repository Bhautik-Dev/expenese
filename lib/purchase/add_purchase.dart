import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenese/controller/product_controller.dart';
import 'package:expenese/controller/purchese_controller.dart';
import 'package:expenese/product/p_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddPurchase extends StatefulWidget {
  final dynamic model;
  const AddPurchase({super.key,this.model});

  @override
  State<AddPurchase> createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  PurchaseController purchaseController=Get.find();
  ProductController productController=Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    purchaseController.SupplierName=TextEditingController(text: widget.model['CName']??"");
    purchaseController.itemList.clear();
    purchaseController.sTotal.value =0;
    purchaseController.total.value=0;
    purchaseController.discountPrice.clear();
    purchaseController.invNo.clear();
    purchaseController.purchaseDate.clear();
  }
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
          "Add Purchese",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:  EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: purchaseController.invNo,
                      decoration: InputDecoration(
                          labelText: "Inv No.",
                          labelStyle: TextStyle(),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)))),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      controller: purchaseController.purchaseDate,
                      enabled: true,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: IconButton(
                              onPressed: () async {
                                purchaseController.dateTime = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2050));
                                if (purchaseController.dateTime != null) {
                                  var d2 = DateFormat('dd/MM/yyyy')
                                      .format(purchaseController.dateTime!);
                                  purchaseController.purchaseDate.text = d2;

                                  setState(() {});
                                }
                              },
                              icon: const Icon(Icons.calendar_today_outlined)),
                          labelText: "Date",
                          border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(4)))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Due Amount : "),
                  Text(
                    "\$0",
                    style: TextStyle(color: Colors.orange),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                // enabled: false,
                controller: purchaseController.SupplierName,
                decoration: InputDecoration(
                    // labelText: widget.model['CName']??"-",
                    // hintText: "Guest",
                    labelStyle: TextStyle(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Item Added",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      Text("Quantity",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ],
                  )),
              Container(
                // height: 50,
                  padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  child:Obx(()=>ListView.separated(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:purchaseController.itemList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(purchaseController.itemList[index]['pName'].toString(),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          purchaseController.itemList[index]['qty'].toString(),
                                          style:
                                          TextStyle(color: Colors.black38),
                                        ),
                                        Text("X",
                                            style: TextStyle(
                                                color: Colors.black38)),
                                        Text(
                                            purchaseController.itemList[index]['pPurchase'].toString(),
                                            style: TextStyle(
                                                color: Colors.black38)),
                                        Text("=",
                                            style: TextStyle(
                                                color: Colors.black38)),
                                        Text(
                                            purchaseController.itemList[index]['totalAmt'].toString(),
                                            style: TextStyle(
                                                color: Colors.black38)),
                                      ],
                                    ),
                                  ])),
                          Expanded(
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      if(purchaseController.itemList[index]['qty'] > 1) {
                                        purchaseController
                                            .itemList[index]['qty'] =
                                            purchaseController
                                                .itemList[index]['qty'] - 1;
                                        int price = int.parse(purchaseController
                                            .itemList[index]['pPurchase'] ??
                                            '0');
                                        purchaseController
                                            .itemList[index]['totalAmt'] =
                                            (purchaseController
                                                .itemList[index]['qty'] * price)
                                                .toString();
                                        purchaseController.subTotal();
                                        setState(() {

                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: 9,
                                  ),
                                  Text(purchaseController.itemList[index]['qty'].toString()),
                                  SizedBox(
                                    width: 9,
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    icon: Icon(Icons.add_circle,
                                        color: Colors.blue),
                                    onPressed: () {
                                      purchaseController.itemList[index]['qty'] = purchaseController.itemList[index]['qty']+1;
                                     int price = int.parse(purchaseController.itemList[index]['pPurchase']??'0');
                                      purchaseController.itemList[index]['totalAmt'] = (purchaseController.itemList[index]['qty'] * price).toString();
                                      purchaseController.subTotal();

                                     setState(() {

                                     });
                                    },
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  InkWell(
                                    onTap: () {
                                     purchaseController.itemList.removeAt(index);
                                     purchaseController.subTotal();
                                     purchaseController.total.value = 0.0;
                                     purchaseController.discount = 0;
                                     purchaseController.discountPrice.clear();
                                    },
                                    child: Container(
                                      color: Colors.deepOrange[50],
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 30,
                      );
                    },
                  ))),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                 var result=await Get.to(ProductHome());
                 if(result!=null){
                   purchaseController.itemList.add(result);
                   purchaseController.subTotal();
                 }

                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Text(
                        "Add Items",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sub Total",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                Obx(()=>       Text(purchaseController.sTotal.value.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 16)),)
                    ],
                  )),
              Container(
                padding:
                EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Discount",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                            child: TextField(
                              controller: purchaseController.discountPrice,
                              keyboardType: TextInputType.number,
                         onChanged: (value) {
                           if (value.isEmpty) {
                             purchaseController.discount = 0;
                             return;
                           }
                           purchaseController.discount =int.parse(value);
                           purchaseController.getDiscount();
                         },
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                hintText: "0",
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total", style: TextStyle(fontSize: 16)),
                     Obx(()=>   Text(purchaseController.total.value.toString(),
                         style: TextStyle(fontSize: 16)),)

                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Payment Type"),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.payment_rounded,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                  DropdownButton<String>(
                    value: purchaseController.selectedItem,
                    items: purchaseController.dropdownItems.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        purchaseController.selectedItem = value!;
                      });
                    },
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(child: Text("Cancel")),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Map<String, dynamic> purchase = {
                          'invNo': purchaseController.invNo.text,
                          'date': purchaseController.purchaseDate.text,
                          'sName':purchaseController.SupplierName.text,
                          // 'partyId': widget.model['id'],
                          'dicount':purchaseController.discountPrice.text,
                          // 'partiesName': widget.model['CName'],
                          // 'items': saleController.itemList,
                          // 'total': saleController.total.value,
                          'paymentType': purchaseController.selectedItem,
                        };
                        FirebaseFirestore.instance
                            .collection("AddPurchase")
                            .add(purchase).then((value) {
                              purchaseController.invNo.clear();
                              purchaseController.purchaseDate.clear();
                              purchaseController.discountPrice.clear();
                              purchaseController.SupplierName.clear();
                        });
                        Get.back();
                      },
                      child: InkWell(
                        onTap: () {
                          Map<String,dynamic>purchaseDetails={
                            'inv':purchaseController.invNo.text,
                            'date':purchaseController.purchaseDate.text,
                            'name':purchaseController.SupplierName.text,
                            'item':purchaseController.itemList,
                            'discount':purchaseController.discountPrice.text,
                            'total':purchaseController.total.value,
                            'paymentType':purchaseController.selectedItem
                          };
                          FirebaseFirestore.instance.collection("purchaseDetails").add(purchaseDetails);
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
