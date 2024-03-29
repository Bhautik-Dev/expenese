import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenese/sale/add_sales.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class SaleHome extends StatefulWidget {
  const SaleHome({super.key});

  @override
  State<SaleHome> createState() => _SaleHomeState();
}
class _SaleHomeState extends State<SaleHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsales();
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
        backgroundColor: Colors.white,
        title: Text(
          "Choose a Customer",
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
              child: ListView.separated(
              itemCount: salesList.length,
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
                                  salesList[index]['CName'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(salesList[index]['PName'])
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddSales(model:salesList[index] ),
                                    ));
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
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> salesList = [];

  Future<void> getsales() async {
    salesList.clear();

    QuerySnapshot<Map<String, dynamic>> list =
        await FirebaseFirestore.instance.collection("PartiesDetails").get();

    for (int i = 0; i < list.docs.length; i++) {
      Map<String,dynamic> party=list.docs[i].data();
      party['id']=list.docs[i].id;
      salesList.add(party);
    }
    setState(() {});
  }
}
