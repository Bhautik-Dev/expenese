import 'package:expenese/controller/parties_controller.dart';
import 'package:expenese/parties/print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartiesDetails extends StatefulWidget {
  final dynamic model;
  const PartiesDetails({super.key,this.model});

  @override
  State<PartiesDetails> createState() => _PartiesDetailsState();
}

class _PartiesDetailsState extends State<PartiesDetails> {
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
            Get.back();
          },
        ),
        title: Text(
          "Customer Details",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Colors.grey,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: Colors.grey,
              ))
        ],
      ),
      body: Obx(() => partiesController.isDetailsLoading.value? Center(child: CircularProgressIndicator()):SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Center(
            child: Column(children: [
              CircleAvatar(
                maxRadius: 70,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.model['CName'],
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.model['CNumber'], style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Icon(
                          Icons.call,
                          size: 30,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Call",
                          style: TextStyle(fontSize: 19),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 25),
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Icon(
                          Icons.message_rounded,
                          size: 30,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Message",
                          style: TextStyle(fontSize: 19),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Icon(
                          Icons.email,
                          size: 30,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(fontSize: 19),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Recent Transactions",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() => ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:partiesController.partyDetailsList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Print(model:partiesController.partyDetailsList[index] ),));
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
                          // offset: Offset.zero,
                          // blurStyle: BlurStyle.outer
                        )]
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Total Product :"),
                              Expanded(child: Text("${partiesController.partyDetailsList[index]['items'][0]['qty']}")),
                              Text("#${partiesController.partyDetailsList[index]['invNo']}")
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
                                  partiesController.partyDetailsList[index]['date'],
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
                              Text("Total :\$${partiesController.partyDetailsList[index]['total']}",
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
              ))
            ]),
          ),
        ),
      ),)
    );
  }
}
