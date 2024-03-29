// import 'package:expense/add_expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenese/controller/expense_controller.dart';
import 'package:expenese/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'add_expense.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {

  ExpenseController expenseController=Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expenseController.getExpense();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading:  IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black, onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) => Home(),));
        },
        ),
        title: const Text(
          "Expense Report",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: expenseController.fDate,
                    enabled: true,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? datePicked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2001),
                                  lastDate: DateTime(2050));
                              if (datePicked != null) {
                                if (expenseController.fromDate != null && expenseController.toDate != null) {
                                  expenseController.getExpense(
                                      fromDate: expenseController.fromDate, toDate: expenseController.toDate);
                                }
                                expenseController.fromDate = datePicked;
                                var d2 =
                                    DateFormat('dd/MM/yyyy').format(datePicked);
                                expenseController.fDate.text = d2;
                                print(
                                    'Date Selected:${datePicked.day}-${datePicked.month}-${datePicked.year}');
                                setState(() {});
                              }
                            },
                            icon: const Icon(Icons.calendar_today_outlined)),
                        labelText: "From Date",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: expenseController.tDate,
                    enabled: true,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? datePicked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2001),
                                  lastDate: DateTime(2050));
                              expenseController.toDate = datePicked;
                              if (datePicked != null) {
                                if (expenseController.fromDate != null && expenseController.toDate != null) {
                                  expenseController.getExpense(
                                      fromDate: expenseController.fromDate, toDate: datePicked);
                                }
                                var d2 =
                                    DateFormat('dd/MM/yyyy').format(datePicked);
                                expenseController.tDate.text = d2;
                                print(
                                    'Date Selected:${datePicked.day}-${datePicked.month}-${datePicked.year}');
                                setState(() {});
                              }
                            },
                            icon: const Icon(Icons.calendar_today_outlined)),
                        labelText: "To Date",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.green[50],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Expense For"),
                  Text("Date"),
                  Text("Amount"),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: expenseController.addExpenseList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(expenseController.addExpenseList[index]['ExpenseName'],
                                style: const TextStyle(fontSize: 14.5)),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              expenseController.addExpenseList[index]['SelectCategory'],
                              style:
                                 const TextStyle(color: Colors.grey, fontSize: 10.5),
                            )
                          ],
                        ),
                        Text(expenseController.formatTimestamp(expenseController.addExpenseList[index]['Date'])),
                        Text(expenseController.addExpenseList[index]['Amount']),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.grey,
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.green[50],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text("Total Expense"), Text("\$${expenseController.totalExpense}")],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: InkWell(
          onTap: () async {

            Get.to(AddExpense())?.then((value) {
              expenseController.getExpense();
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 50,
            decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(10)),
            child: const Center(
                child: Text(
              "Add Expense",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )),
          ),
        ),
      ),
    );
  }


}
