import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenese/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'controller/expense_controller.dart';
import 'expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();

  ExpenseController expenseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Add Expense",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Expense(),
                ));
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: expenseController.date,
                  enabled: true,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            expenseController.dateTime = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime(2050));

                            if (expenseController.dateTime != null) {
                              var d2 = DateFormat('dd/MM/yyyy')
                                  .format(expenseController.dateTime!);
                              expenseController.date.text = d2;

                              setState(() {});
                            }
                          },
                          icon: const Icon(Icons.calendar_today_outlined)),
                      labelText: "From Date",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)))),
                ),
                const SizedBox(
                  height: 18,
                ),
                InkWell(
                  onTap: () async {
                    String result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Category(),
                        ));
                    if (result.isNotEmpty) {
                      expenseController.selectCatrgory.text = result;
                      setState(() {});
                    }
                  },
                  child: TextField(
                    controller: expenseController.selectCatrgory,
                    enabled: false,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        hintText: "Select Category",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                TextFormField(
                  controller: expenseController.eFor,
                  // enabled: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter expense title";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      // labelText: "Expense For",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Enter Name",
                      label: Text("Expense For"),
                      hintStyle: TextStyle(color: Colors.black38),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                ),
                const SizedBox(
                  height: 18,
                ),
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          hintText: 'Please select expense',
                          labelText: " Payment Type",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      isEmpty: expenseController.currentSelectedValue == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: expenseController.currentSelectedValue,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              expenseController.currentSelectedValue =
                                  newValue!;
                              state.didChange(newValue);
                            });
                          },
                          items:
                              expenseController.currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                TextFormField(
                  controller: expenseController.amount,
                  // enabled: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter amount";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Amount",
                      hintText: "Enter Amount",
                      hintStyle: TextStyle(color: Colors.black38),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 18,
                ),
                TextField(
                  controller: expenseController.rNumber,
                  // enabled: false,
                  decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      counterText: "",
                      labelText: "Reference Number",
                      hintText: "Enter reference number",
                      hintStyle: TextStyle(color: Colors.black38),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
                const SizedBox(
                  height: 18,
                ),
                TextField(
                  controller: expenseController.note,
                  // enabled: false,
                  decoration: const InputDecoration(
                      hintText: "Note",
                      hintStyle: TextStyle(color: Colors.black38),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                ),
                const SizedBox(
                  height: 27,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> expense = {
                        'Date': Timestamp.fromDate(expenseController.dateTime!),
                        'SelectCategory': expenseController.selectCatrgory.text,
                        'ExpenseName': expenseController.eFor.text,
                        'PaymentType': expenseController.currentSelectedValue,
                        'Amount': expenseController.amount.text,
                        'RNumber': expenseController.rNumber.text,
                        'Note': expenseController.note.text,
                      };
                      FirebaseFirestore.instance
                          .collection("expense")
                          .add(expense);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
