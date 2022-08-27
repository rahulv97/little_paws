import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:little_paws/services/database_service.dart';
import 'package:little_paws/services/message_tile.dart';

class MessageScreen extends StatefulWidget {
  final chatID;
  final usr_img;
  final name;
  final with_id;
  const MessageScreen(
      {Key? key, this.chatID, this.usr_img, this.name, this.with_id})
      : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

// class ChatMessage {
//   String messageContent;
//   String messageType;
//   ChatMessage({required this.messageContent, required this.messageType});
// }

// List<ChatMessage> messages = [];

int index = 0;

var user_img;
var user_name;
var chat_id = "";
var my_message = "";
var with_id = "";
var status = "";

//var scrollController = new ScrollController();
var text_controller = new TextEditingController();

class _MessageScreenState extends State<MessageScreen> {
  getChatandAdmin() {
    DatabaseService().getChats(chat_id).then((val) {
      setState(() {
        print("object" + "${chat_id}");
        chats = val;
      });
    });
  }

  @override
  void initState() {
    user_img = widget.usr_img;
    user_name = widget.name;
    chat_id = widget.chatID;
    with_id = widget.with_id;

    getChatandAdmin();

    super.initState();
  }

  Stream<QuerySnapshot>? chats;

  @override
  Widget build(BuildContext context) {
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

    sendMessage(String currentDateTime, String msg, String sender) {
      if (msg.isNotEmpty) {
        Map<String, dynamic> chatMessageMap = {
          "message": msg,
          "sender": sender,
          "time": DateTime.now().millisecondsSinceEpoch,
        };

        DatabaseService().sendMessage(chat_id, chatMessageMap);
      }
    }

    chatMessages() {
      return StreamBuilder(
        stream: chats,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                        message: snapshot.data.docs[index]['message'],
                        sender: snapshot.data.docs[index]['sender'],
                        sentByMe: FirebaseAuth.instance.currentUser!.uid ==
                            snapshot.data.docs[index]['sender']);
                  },
                )
              : Container();
        },
      );
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
            child: chatMessages(),
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
                        var currentDateTime =
                            DateTime.now().millisecondsSinceEpoch.toString();
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
