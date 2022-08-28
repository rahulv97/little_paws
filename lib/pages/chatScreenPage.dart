import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:little_paws/showToast.dart';

import 'message.dart';

class ChatScreenPage extends StatefulWidget {
  const ChatScreenPage({Key? key}) : super(key: key);

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class ChatsData {
  String chat_id, current_date_time, user_image, user_name, with_id, with_city;
  ChatsData(
      {required this.chat_id,
      required this.current_date_time,
      required this.user_image,
      required this.user_name,
      required this.with_id,
      required this.with_city});
}

List<ChatsData> chatsList = [];

class _ChatScreenPageState extends State<ChatScreenPage> {
  @override
  Widget build(BuildContext context) {
    getChats() {
      DatabaseReference databaseReference = FirebaseDatabase.instance
          .ref("users/" + FirebaseAuth.instance.currentUser!.uid + "/chats");
      databaseReference.orderByChild("currentDateTime").onValue.listen((event) {
        chatsList.clear();
        for (var data in event.snapshot.children) {
          //ShowToast().showToast(data.child("chatID").value.toString());
          chatsList.add(ChatsData(
              chat_id: data.child("chatID").value.toString(),
              current_date_time: data.child("currentDateTime").value.toString(),
              user_image: data.child("with_img").value.toString(),
              user_name: data.child("with_name").value.toString(),
              with_id: data.key.toString(),
              with_city: data.child("with_city").value.toString()));
        }
        setState(() {
          chatsList = chatsList.reversed.toList();
        });
      });
      return chatsList;
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Message",
                  style: TextStyle(
                      fontFamily: 'Bold', fontSize: 24, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 5, right: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(15, 0, 0, 0),
                                blurRadius: 5,
                              )
                            ]),
                        child: ListTile(
                          onTap: () {
                            //ShowToast().showToast(getChats()[index].with_id);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MessageScreen(
                                          chatID: getChats()[index].chat_id,
                                          usr_img: getChats()[index].user_image,
                                          name: getChats()[index].user_name,
                                          with_id: getChats()[index].with_id,
                                        )));
                          },
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: getChats()[index].user_image != "abc"
                                  ? Image.network(
                                      getChats()[index].user_image,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/prof_pic.jpg",
                                      fit: BoxFit.cover,
                                    )),
                          title: Text(
                            getChats()[index].user_name,
                            style: TextStyle(fontFamily: 'Bold'),
                          ),
                          subtitle: Text(getChats()[index].with_city),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    );
                  },
                  itemCount: getChats().length,
                ),
              )
            ],
          ),
        ));
  }
}
