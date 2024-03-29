import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenese/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Chatpage extends StatefulWidget {
  final dynamic model;

  Chatpage({super.key, this.model});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  ScrollController scrollController = ScrollController();
  UserController userController = Get.find();
  final TextEditingController _textEditingController = TextEditingController();
  Map<String, dynamic>MsgMap = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // scrollToBottom();
    });
  }

  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// resizeToAvoidBottomInset: true,
      body: Stack(
          children: [
        Image.asset(
          'assets/image/HluF7g.jpg',
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black12,
        ),
        Container(
          padding: EdgeInsets.only(
            bottom: 10,
          ),
          child: Column(
            children: [
              Container(
                height: 95,
                padding: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(color: Colors.teal),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),

                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                       

                      SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(widget.model['name'] ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18)),
                            SizedBox(
                              height: 2,
                            ),

                            StreamBuilder(
                                stream: FirebaseFirestore.instance.collection(
                                    'MSG')
                                    .doc(userController.groupChatId)
                                    .snapshots(),
                                builder:(context, snapshot) {
                                  String isTyping = "";
                                  if(snapshot.hasData){
                                    Map<String, dynamic>? map = snapshot.data!.data();
                                    debugPrint(map.toString());
                                    if(map != null){
                                      isTyping = map['${widget.model['id']}-isTyping'] == true ?"typing...":"Online";
;                                    }
                                  }
                                  return Text(isTyping,style: TextStyle(color: Colors.white,fontSize: 12),);
                                },

                            )

                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {

                          },
                          icon: Icon(
                            Icons.video_call,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.call,
                            color: Colors.white,
                          )),
                      PopupMenuButton(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        itemBuilder: (context,) =>
                        [
                          const PopupMenuItem(
                              value: '1', child: Text('View Contact')),
                          const PopupMenuItem(
                              value: '2',
                              child: Text('Media, links, and docs')),
                          const PopupMenuItem(
                              value: '3', child: Text('Search')),
                          const PopupMenuItem(
                              value: '4', child: Text('Mute notifications')),
                          const PopupMenuItem(
                              value: '5', child: Text('Disappearing messages')),
                          const PopupMenuItem(
                              value: '6', child: Text('Wallpaper')),
                          const PopupMenuItem(value: '7', child: Text('More')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('MSG')
                      .doc(userController.groupChatId)
                      .collection(userController.groupChatId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final messages = snapshot.data!.docs;
                    return ListView.builder(
                        // physics: ClampingScrollPhysics(),
                      // physics: BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal),
                      controller: scrollController,
                      reverse: false,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        // final message = messages[index];
                        return Container(
                          padding:
                          EdgeInsets.only(left: 15, right: 15, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if(messages[index]['SendId'] == userController.myDetails['id'])...[ Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(10.0),
                                        ),

                                      ),
                                      child:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            messages[index]['content'],style: TextStyle(color: Colors.white),),
                                          SizedBox(height: 3,),
                                          Text(
                                            getTime(DateTime.parse(messages[index]['timestamp'].toDate().toString())),
                                            style: TextStyle(color: Colors.white54,fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )],
                            if(messages[index]['SendId'] == widget.model['id'])...[
                              Container(

                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(20.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                ),
                                child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      messages[index]['content'],style: TextStyle(color: Colors.white),),
                                    SizedBox(height: 3,),
                                    Text(
                                      getTime(DateTime.parse(messages[index]['timestamp'].toDate().toString())),
                                      style: TextStyle(color: Colors.white54,fontSize: 12),
                                    ),
                                  ],
                                ),

                              )
                            ]

                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                        scrollPadding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).viewInsets.bottom),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"^\s"))
                        ],
                        cursorColor: Colors.black12,
                        controller: _textEditingController,
                        onChanged: (value) {
                          
                          if (value.isNotEmpty) {
                            userController.isShowSendButton.value = true;

                          } else {
                            userController.isShowSendButton.value = false;
                          }

                          if (value.isNotEmpty) {
                            FirebaseFirestore.instance.collection('MSG').doc(
                                userController.groupChatId).update({
                              "${userController.myDetails['id']}-isTyping": true
                            });
                            setState((){});
                            Future.delayed(Duration(seconds: 1)).whenComplete((){
                              FirebaseFirestore.instance.collection('MSG').doc(
                                      userController.groupChatId).update({
                                      "${userController.myDetails['id']}-isTyping": false
                                    });
                              setState(() {

                              });
                            });
                          }
                          // } else {
                          //   FirebaseFirestore.instance.collection('MSG').doc(
                          //       userController.groupChatId).update({
                          //     "${userController.myDetails['id']}-isTyping": false
                          //   });
                          // }

                          // isTyping=userController.myDetails['id'] == widget.model['id']?true:false;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.teal[50],
                            filled: true,
                            // disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
                            focusedBorder: InputBorder.none,

                            // focusColor: Colors.black,
                            hintText: 'Type a message',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                              borderRadius: BorderRadius.all(Radius.circular(10)
                            ),
                            ),
                            prefixIcon: InkWell(
                              onTap: () {

                              },
                              child: Icon(
                                Icons.emoji_emotions,
                                color: Colors.black54,
                              ),
                            ),
                            suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Transform.rotate(
                                      angle: -35,
                                      child: Icon(
                                        Icons.attach_file_sharp,
                                        color: Colors.black54,
                                      )),
                                  SizedBox(
                                    width: 9,
                                  ),
                                  Obx(() =>
                                  userController.isShowSendButton.value ==
                                      false
                                      ? Icon(Icons.camera_alt,
                                      color: Colors.black54)
                                      : SizedBox()),
                                  Obx(() =>
                                  userController.isShowSendButton.value ==
                                      false
                                      ? SizedBox(
                                    width: 9,
                                  )
                                      : SizedBox())
                                ])), // decoration: InputDecoration(
                        //   hintText: 'Type a message',
                        // ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Obx(() =>
                    userController.isShowSendButton.value == false
                        ? CircleAvatar(
                      backgroundColor: Colors.teal,
                      maxRadius: 25,
                      child: IconButton(
                        icon: Icon(
                          Icons.mic,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    )
                        : CircleAvatar(
                      backgroundColor: Colors.black26,
                      maxRadius: 25,
                      child: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          if (_textEditingController.text.isNotEmpty) {
                            FirebaseFirestore.instance
                                .collection('MSG')
                                .doc(userController.groupChatId)
                                .collection(userController.groupChatId)
                                .doc(DateTime
                                .now()
                                .microsecondsSinceEpoch
                                .toString())
                                .set({
                              'SendId': userController.myDetails['id'],
                              'recivedId': widget.model['id'],
                              'content': _textEditingController.text,
                              'timestamp':DateTime.now(),
                            }).then((value) {

                            });
                            scrollToBottom();
                          }


                          _textEditingController.clear();
                          userController.isShowSendButton.value = false;
                        },
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),

    );
  }

  void _sendMessage() async {
    final text = _textEditingController.text.trim();
    if (text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('messages').add({
          'text': text,
          'timestamp': FieldValue.serverTimestamp(),
        });
        _textEditingController.clear();
      } catch (e) {
        print('Error sending message: $e');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to send message. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 600,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    setState(() {});
  }

  getTime(date){
   return DateFormat.jm().format(date);
  }
}
