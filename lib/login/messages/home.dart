import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenese/controller/user_controller.dart';
import 'package:expenese/login/messages/chat.dart';
import 'package:expenese/login/messages/login.dart';
import 'package:expenese/login/messages/new_add.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePageMSG extends StatefulWidget {
  const HomePageMSG({super.key});

  @override
  State<HomePageMSG> createState() => _HomePageMSGState();
}

class _HomePageMSGState extends State<HomePageMSG> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.getUserData();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final getStorage = GetStorage();
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Icon(
              Icons.menu,
              color: Colors.white,
            )),
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(child: Image.asset("assets/image/messenger2.png",height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,)),
            SizedBox(width: 10,),
            Text(
              "Messages",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (
                context,
                ) =>
            [
              const PopupMenuItem(value: '1', child: Text('New group')),
              const PopupMenuItem(
                  value: '2', child: Text('New broadcast')),
              const PopupMenuItem(
                  value: '3', child: Text('Linked devices')),
              const PopupMenuItem(
                  value: '4', child: Text('Starred messages')),
              const PopupMenuItem(value: '5', child: Text('Payments')),
              const PopupMenuItem(value: '6', child: Text('Settings')),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: TextButton(
          onPressed: () {
            getStorage.write('isLogin', false);

            Get.to(LoginChat());
          },
          child: Text("LOGOUT"),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/image/HluF7g.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black45,
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  Obx(
                    () => ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: userController.users.length,
                      itemBuilder: (context, index) {
                        String userId = userController.myDetails['id'];
                        String peerId = userController.users[index]['id'];
                        String groupId = "";
                        if (userId.hashCode <= peerId.hashCode) {
                          groupId = '$userId-$peerId';
                        } else {
                          groupId = '$peerId-$userId';
                        }
                        return StreamBuilder(
                            stream:  FirebaseFirestore.instance.collection('MSG').doc(groupId).collection(groupId).orderBy("timestamp",descending: true).limit(1).snapshots(),
                            builder: (context, snapshot) {
                              String lastMessage = "";
                              bool isSendMe = false;

                              if(snapshot.hasData){
                                if(snapshot.data!.docs.isNotEmpty){
                                  lastMessage = snapshot.data!.docs[0]['content'];
                                  isSendMe = snapshot.data!.docs[0]['SendId'] == userController.myDetails['id'] ? true : false;
                                }

                              }
                              return   InkWell(
                                onTap: () {
                                  userController
                                      .idData(userController.users[index]['id']);
                               userController.getTyping(peerId: userController.users[index]['id']);

                                  Get.to(Chatpage(
                                    model:userController.users[index],

                                  ));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  // decoration: BoxDecoration(
                                  //     // color: Colors.black12,
                                  //     borderRadius: BorderRadius.circular(10),
                                  //     border: Border.all(color: Colors.black12)),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 2,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      stops: [0.4, 1.0],
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(backgroundColor: Colors.teal.shade100),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              userController.users[index]['name'] ??
                                                  "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            Text(lastMessage,
                                              style:
                                              TextStyle(color: isSendMe ? Colors.black26 : Colors.black ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Text("05:25",
                                          style: TextStyle(color: Colors.grey))
                                    ],
                                  ),
                                ),
                              );
                            },);

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
          ),
        ],
      ),
    );
  }
}
