import 'package:flutter/material.dart';

class Print extends StatefulWidget {
  final dynamic model;
   const Print({super.key,this.model});

  @override
  State<Print> createState() => _PrintState();
}

class _PrintState extends State<Print> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 60,horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  maxRadius: 30,
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.model['partiesName'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                    Text("IND",style: TextStyle(color: Colors.black26,fontSize: 16)),
                    Text("Loading...",style: TextStyle(color: Colors.black26,fontSize: 16))
                  ],
                )
              ],
            ),
            SizedBox(height: 25,),
            Divider(color: Colors.black26,),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: Text("Bill To")),
                Text("Invoice#"),
                Text(widget.model['invNo']??'')
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(child: Text("Saiful",style: TextStyle(color: Colors.grey))),
                Text(widget.model['date'],style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(child: Text("01712022529",style: TextStyle(color: Colors.grey))),
                Text("12:50",style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 20,),
            Divider(color: Colors.black26,),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Product"),
                Text("Unit Price"),
                Text("Quantity"),
                Text("Total Price"),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.model['items'][0]['pName']??'',style: TextStyle(color: Colors.grey),),
                Text(widget.model['total'].toString()??'',style: TextStyle(color: Colors.grey)),
                Text(widget.model['items'][0]['qty'].toString(),style: TextStyle(color: Colors.grey)),
                Text(widget.model['total'].toString()??'',style: TextStyle(color: Colors.grey)),
              ],
            ),
           SizedBox(height: 10,),
           Divider(),
            Row(
              children: [
                Spacer(),
                Expanded(child: Text("SubTotal",style: TextStyle(color: Colors.grey))),
                Text("\$${widget.model['total'].toString()??''}")
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Spacer(),
                Expanded(child: Text("TotalVat",style: TextStyle(color: Colors.grey))),
                Text("\$0.00")
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Spacer(),
                Expanded(child: Text("Discount",style: TextStyle(color: Colors.grey))),
                Text("${widget.model['dicount'].toString()??''}\%"),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Spacer(),
                Expanded(child: Text("Total Payable",style: TextStyle(color: Colors.black))),
                Text("\$${discount().toString()}")
              ],
            ),
            SizedBox(height: 10,),
            Divider(),
            SizedBox(height: 15,),
            Expanded(child: Text("Thank You For Your Purchase")),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                color: Colors.indigoAccent,
              ),
              child: Text("Print",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600),),
            )
          ],
        ),
      ),
    );
  }

  discount(){
   double dis = double.parse(widget.model['dicount']??'0.0');
   double subTotal = double.parse(widget.model['total'].toString());

   double dValue = subTotal * dis / 100 ;
   debugPrint("DIS=> ${dValue}");

   return (subTotal - dValue).toString();

  }
}
