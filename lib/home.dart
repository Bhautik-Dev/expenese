import 'package:expenese/expense.dart';
import 'package:expenese/parties/parties_home.dart';
import 'package:expenese/product/p_home.dart';
import 'package:expenese/purchase/purchase_list.dart';
import 'package:expenese/purchase/purchese_home.dart';
import 'package:expenese/sale/sale_home.dart';
import 'package:expenese/sale/sales_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(

        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(Icons.school,color: Colors.black,),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("Acnoo.com",style: TextStyle(color: Colors.black)),
            Text("Free Plan",style: TextStyle(color: Colors.black,fontSize: 15)),
          ],
        ),
        actions: [Icon(Icons.notifications_active,color: Colors.black,),SizedBox(width: 15,)],

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
               color: Colors.orangeAccent[50]
        ) ,
                  child: Column(
                    children: [
                      InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Expense(),));
                      },
                      child: Image.asset("assets/image/expenses-report-8860117-7300050.webp",height: 100,width: 100,)),
                      Text("Expense",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
                // SizedBox(width: 10,),
                Container(
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.orangeAccent[50]
                  ) ,
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductHome(),));
                          },
                          child: Image.asset("assets/image/4863042.webp",height: 100,width: 100,)),
                      Text("Product",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
                // SizedBox(width: 10,),
                Container(
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.orangeAccent[50]
                  ) ,
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PartiesHome(),));
                          },
                          child: Image.asset("assets/image/expenses-report-8860117-7300050.webp",height: 100,width: 100,)),
                      Text("Parties",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.orangeAccent[50]
                  ) ,
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SaleHome(),));
                          },
                          child: Image.asset("assets/image/expenses-report-8860117-7300050.webp",height: 100,width: 100,)),
                      Text("Sale",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
                Container(
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.orangeAccent[50]
                  ) ,
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SalesList(),));
                          },
                          child: Image.asset("assets/image/expenses-report-8860117-7300050.webp",height: 100,width: 100,)),
                      Text("Sales List",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
                Container(
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.orangeAccent[50]
                  ) ,
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PurcheseHome(),));
                          },
                          child: Image.asset("assets/image/expenses-report-8860117-7300050.webp",height: 100,width: 100,)),
                      Text("Purchese",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.orangeAccent[50]
              ) ,
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseList(),));
                      },
                      child: Image.asset("assets/image/expenses-report-8860117-7300050.webp",height: 100,width: 100,)),
                  Text("Purchase List",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
