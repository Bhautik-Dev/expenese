import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenese/product/p_home.dart';
import 'package:expenese/sale/sale_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/sale_controller.dart';

class AddSales extends StatefulWidget {
  dynamic model;

  AddSales({super.key, this.model});

  @override
  State<AddSales> createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saleController.total.value = 0.0;
    saleController.invNo.clear();
    saleController.subTotal.value = 0;
    // saleController.itemList.clear();
  }

  SaleController saleController = Get.find();

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
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SaleHome(),
                ));
          },
        ),
        title: Text(
          "Add Sales",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: saleController.invNo,
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
                      controller: saleController.salesDate,
                      enabled: true,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: IconButton(
                              onPressed: () async {
                                saleController.dateTime = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2050));

                                if (saleController.dateTime != null) {
                                  var d2 = DateFormat('dd/MM/yyyy')
                                      .format(saleController.dateTime!);
                                  saleController.salesDate.text = d2;

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
                controller: TextEditingController(text: widget.model['CName']),
                // enabled: false,
                decoration: InputDecoration(
                    labelText: "Customer Name",
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
                  child: Obx(() => ListView.separated(
                        // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: saleController.itemList.length,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text(
                                      saleController.itemList[index]['pName'] ??
                                          '',
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
                                          saleController.itemList[index]['qty']
                                              .toString(),
                                          style:
                                              TextStyle(color: Colors.black38),
                                        ),
                                        Text("X",
                                            style: TextStyle(
                                                color: Colors.black38)),
                                        Text(
                                            saleController.itemList[index]
                                                    ['pPurchase'] ??
                                                '',
                                            style: TextStyle(
                                                color: Colors.black38)),
                                        Text("=",
                                            style: TextStyle(
                                                color: Colors.black38)),
                                        Text(
                                            saleController.itemList[index]
                                                    ['totalAmt']
                                                .toString(),
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
                                      if (saleController.itemList[index]
                                              ['qty'] >
                                          1) {
                                        saleController.itemList[index]['qty'] =
                                            saleController.itemList[index]
                                                    ['qty'] -
                                                1;
                                        saleController.itemList[index]
                                            ['totalAmt'] = int.parse(
                                                saleController.itemList[index]
                                                    ['pPurchase']) *
                                            saleController.itemList[index]
                                                ['qty'];
                                      }

                                      saleController.updateSubTotalPrice();
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(
                                    width: 9,
                                  ),
                                  Text(saleController.itemList[index]['qty']
                                      .toString()),
                                  SizedBox(
                                    width: 9,
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    icon: Icon(Icons.add_circle,
                                        color: Colors.blue),
                                    onPressed: () {
                                      if (saleController.itemList[index]
                                              ['qty'] >=
                                          1) {
                                        saleController.itemList[index]['qty'] =
                                            saleController.itemList[index]
                                                    ['qty'] +
                                                1;
                                        saleController.itemList[index]
                                            ['totalAmt'] = int.parse(
                                                saleController.itemList[index]
                                                    ['pPurchase']) *
                                            saleController.itemList[index]
                                                ['qty'];
                                      }

                                      saleController.updateSubTotalPrice();
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      saleController.itemList.removeAt(index);
                                      saleController.updateSubTotalPrice();
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductHome(),
                      ));
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
                      Obx(() => Text(saleController.subTotal.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 16))),
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
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              saleController.discountPer = 0;
                              return;
                            }
                            saleController.discountPer = int.parse(value);
                            saleController.calculateDiscount();
                          },
                          controller: saleController.discountPrice,
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
                        Obx(
                          () => Text(saleController.total.toString(),
                              style: TextStyle(fontSize: 16)),
                        ),
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
                    value: saleController.selectedItem,
                    items: saleController.dropdownItems.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        saleController.selectedItem = value!;
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
                        Map<String, dynamic> sales = {
                          'invNo': saleController.invNo.text,
                          'date': saleController.salesDate.text,
                          'partyId': widget.model['id'],
                          'dicount': saleController.discountPrice.text,
                          'partiesName': widget.model['CName'],
                          'items': saleController.itemList,
                          'total': saleController.total.value,
                          'paymentType': saleController.selectedItem,
                        };
                        FirebaseFirestore.instance
                            .collection("Sales")
                            .add(sales);
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
