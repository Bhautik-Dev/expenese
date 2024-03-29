import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenese/controller/parties_controller.dart';
import 'package:expenese/home.dart';
import 'package:expenese/parties/parties_add.dart';
import 'package:expenese/parties/parties_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartiesHome extends StatefulWidget {
  const PartiesHome({super.key});

  @override
  State<PartiesHome> createState() => _PartiesHomeState();
}

class _PartiesHomeState extends State<PartiesHome> {
  PartiesController partiesController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(microseconds: 500)).then((value){
      partiesController.getParty();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Parties", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PartiesAdd(),
                  )).then((value) {
                partiesController.getParty();
              });
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Obx(()=> partiesController.isLoading.value?Center(child: CircularProgressIndicator()):ListView.separated(
        itemCount: partiesController.partyList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {

              partiesController.getPartiesDetails(id: partiesController.partyList[index]['id']);

              Navigator.push(context, MaterialPageRoute(builder: (context) => PartiesDetails(model: partiesController.partyList[index]),));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black26, width: 1),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.1),blurRadius: 2,spreadRadius: 2,offset: Offset(1,1))
                  ],
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Customer Name  :",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        partiesController.partyList[index]['CName'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Company Name       :",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        partiesController.partyList[index]['PName'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Contact Number  :",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        partiesController.partyList[index]['CNumber'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.indigoAccent),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 15,
          );
        },
      ),),
    );
  }
}
