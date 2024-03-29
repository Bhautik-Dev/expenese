import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpenseController extends GetxController{
  TextEditingController dat = TextEditingController();
  TextEditingController fDate = TextEditingController();
  TextEditingController tDate = TextEditingController();
  int totalExpense = 0;
  DateTime? fromDate;
  DateTime? toDate;

  List<dynamic> addExpenseList = [];

  String formatTimestamp(timestamp) {
    DateTime d = timestamp.toDate();
    String formattedDate = DateFormat('MMM d, y').format(d);
    return formattedDate;
  }

  Future<void> getExpense({fromDate, toDate}) async {
    addExpenseList.clear();
    QuerySnapshot querySnapshot;
    if (fromDate != null) {
      querySnapshot = await FirebaseFirestore.instance
          .collection("expense")
          .where("Date", isGreaterThanOrEqualTo: fromDate)
          .where("Date", isLessThanOrEqualTo: toDate)
          .get();
    } else {
      querySnapshot =
      await FirebaseFirestore.instance.collection("expense").get();
    }

    totalExpense = 0;
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      dynamic item = querySnapshot.docs[i].data();
      item['id'] = querySnapshot.docs[i].id;
      addExpenseList.add(item);
      totalExpense = totalExpense + int.parse(item['Amount']);
    }

  }

  TextEditingController selectCatrgory = TextEditingController();
  TextEditingController date = TextEditingController();
  DateTime? dateTime;
  TextEditingController eFor = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController rNumber = TextEditingController();
  TextEditingController note = TextEditingController();
  String dropdownValue = "Cash";
  final currencies = [
    "Cash",
    "Bank",
    "Card",
    "Mobile Payment",
    "Snacks",
  ];
  String currentSelectedValue = "Cash";

}