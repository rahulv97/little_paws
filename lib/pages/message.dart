import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_10.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:little_paws/pages/detailsPage.dart';

import '../showToast.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

List<ChatMessage> messages = [];

int index = 0;

var user_img;
var user_name;
var chat_id = "";
var my_message = "";
var with_id = "";
var status = "";

var scrollController = new ScrollController();
var text_controller = new TextEditingController();

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    setState(() {
      user_img = arguments["usr_img"];
      user_name = arguments["name"];
      chat_id = arguments["chatID"];
      with_id = arguments["with_id"];
    });

    getStatus() {
      DatabaseReference statusRef =
          FirebaseDatabase.instance.ref("users").child(with_id).child("status");
      statusRef.onValue.listen((event) {
        setState(() {
          status = event.snapshot.value.toString();
        });
      });
    }

    getStatus();

    getChat() {
      //print("Working Chat");
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("chats/" + chat_id);
      databaseReference.onValue.listen((event) {
        messages.clear();
        for (var data in event.snapshot.children) {
          messages.add(ChatMessage(
              messageContent: data.child("message").value.toString(),
              messageType: data.child("sender").value.toString()));
          //print("Chat" + data.child("message").value.toString());
        }
        // setState(() {});
        scrollController.jumpTo(scrollController.position.maxScrollExtent);

        try {
          if (index < messages.length) {
            //print("if not equal: " + index.toString());

            //scrollController.jumpTo(scrollController.position.maxScrollExtent);
            Future.delayed(const Duration(milliseconds: 1000), () {
              setState(() {});
              index = messages.length;
            });
          } else {}
        } catch (e) {}

        // try {
        //   if (index != messages.length) {
        //     setState(() {});

        //     index = messages.length;
        //   } else {}
        // } catch (e) {
        //   ShowToast().showToast(e);
        // }

        //messages = messages.reversed.toList();
        //scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
      //scrollController.jumpTo(scrollController.position.maxScrollExtent);

      return messages;
    }

    Future<void> sendMessage(
        String currentDateTime, String msg, String sender) async {
      DatabaseReference firebaseDatabase = FirebaseDatabase.instance.ref(
          "chats/" +
              chat_id +
              "/" +
              currentDateTime
                  .replaceAll(" ", "")
                  .replaceAll("-", "")
                  .replaceAll(".", "")
                  .replaceAll(":", ""));
      await firebaseDatabase
          .set({
            "message": msg,
            "sender": sender,
            "datetime": currentDateTime,
          })
          .onError(
              (error, stackTrace) => ShowToast().showToast(error.toString()))
          .then((value) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
            // scrollController.animateTo(
            //   scrollController.position.maxScrollExtent,
            //   curve: Curves.easeOut,
            //   duration: const Duration(milliseconds: 0),
            // );
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                user_img,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Text(
                  user_name,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(status,
                    style: TextStyle(color: Colors.black, fontSize: 10))
              ],
            )
          ],
        ),
        actions: [
          const Icon(
            Icons.more_vert,
            size: 30,
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 90),
            child: ListView.builder(
              controller: scrollController,
              itemCount: getChat().length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              //physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 10),
                  child: ChatBubble(
                      alignment: (messages[index].messageType !=
                              FirebaseAuth.instance.currentUser!.uid
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent,
                            style: const TextStyle(fontSize: 15),
                          )),
                      backGroundColor: (messages[index].messageType !=
                              FirebaseAuth.instance.currentUser!.uid
                          ? Colors.grey.shade200
                          : Colors.blue[200]),
                      clipper: ChatBubbleClipper10(
                        type: (messages[index].messageType !=
                                FirebaseAuth.instance.currentUser!.uid
                            ? BubbleType.receiverBubble
                            : BubbleType.sendBubble),
                      )),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              height: 100,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          boxShadow: [
                            const BoxShadow(
                                color: const Color.fromARGB(49, 0, 0, 0),
                                blurRadius: 10)
                          ],
                          color: Colors.white),
                      child: TextField(
                        controller: text_controller,
                        onChanged: (value) {
                          my_message = value;
                        },
                        decoration: const InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (my_message == "") {
                      } else {
                        var currentDateTime = DateTime.now().toString();
                        var sender = FirebaseAuth.instance.currentUser!.uid;
                        sendMessage(currentDateTime, my_message, sender);
                        text_controller.text = "";
                        //ShowToast().showToast();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 4),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(85, 0, 64, 255),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.send_rounded,
                        color: const Color.fromARGB(255, 0, 64, 255),
                        size: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
