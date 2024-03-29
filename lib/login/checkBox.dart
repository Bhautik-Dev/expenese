import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({super.key});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  List<Map<dynamic, dynamic>> checkBoxList = [];
  List<Map<dynamic, dynamic>> switchList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkBoxList.add({
      "text": "Bhautik",
      "isCheck": false,
    });
    checkBoxList.add({
      "text": "Prince",
      "isCheck": false,
    });
    checkBoxList.add({
      "text": "Aarsh",
      "isCheck": false,
    });
    checkBoxList.add({
      "text": "Dipesh",
      "isCheck": false,
    });
    checkBoxList.add({
      "text": "Jack",
      "isCheck": false,
    });
    switchList.add({
      "text": "Light",
      "isOn": false,
    });
    switchList.add({
      "text": "Fan",
      "isOn": false,
    });
    switchList.add({
      "text": "Computer",
      "isOn": false,
    });
    switchList.add({
      "text": "TV",
      "isOn": false,
    });
    switchList.add({
      "text": "Friz",
      "isOn": false,
    });
  }

  int count = 0;

  // var isSelected=true;
  List<dynamic> boxList = [];
  List<dynamic> switchResultList = [];
  String boxcheck = "";
  String Switchcheck = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Check Box")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: checkBoxList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Checkbox(
                      value: checkBoxList[index]['isCheck'],
                      onChanged: (bool? value) {
                        checkBoxList[index]['isCheck'] = value!;
                        setState(() {});
                      },
                    ),
                    Text(
                      checkBoxList[index]['text'] ?? "",
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                );
              },
            ),
            InkWell(
                onTap: () {
                  count = 0;
                  boxList.clear();
                  for (int i = 0; i < checkBoxList.length; i++) {
                    if (checkBoxList[i]['isCheck'] == true) {
                      boxList.add(checkBoxList[i]['text']);
                    }
                  }
                  boxcheck = boxList.join(" , ");
                  setState(() {});
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text("Add"),
                )),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const Text(
                      "Result",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Check Box Result : ",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                boxcheck,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                        ),
                      ],
                    ),
                  ],
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: switchList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Switch(
                      value: switchList[index]['isOn'],
                      onChanged: (bool? value) {
                        switchList[index]['isOn'] = value!;
                        setState(() {});
                      },
                    ),
                    Text(switchList[index]['text'])
                  ],
                );
              },
            ),
            InkWell(
              onTap: () {
                switchResultList.clear();
                for(int i=0;i<switchList.length;i++){
                  if(switchList[i]['isOn']==true){
                    switchResultList.add(switchList[i]['text']??"");
                  }
                }
                Switchcheck=switchResultList.join(" , ");
                setState(() {

                });
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: const Text("ON/OFF"),
              ),
            ),
            Container(
                margin:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                padding:
                const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const Text(
                      "Result",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Switch On Result: ",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                Switchcheck,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
