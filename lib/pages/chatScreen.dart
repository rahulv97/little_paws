import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:little_paws/showToast.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class ChatsData {
  String chat_id, current_date_time, user_image, user_name, with_id;
  ChatsData(
      {required this.chat_id,
      required this.current_date_time,
      required this.user_image,
      required this.user_name,
      required this.with_id});
}

List<ChatsData> chatsList = [];

class _ChatScreenState extends State<ChatScreen> {
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
              with_id: data.key.toString()));
        }
        setState(() {
          chatsList = chatsList.reversed.toList();
        });
      });
      return chatsList;
    }

    return Scaffold(
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
                  padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
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
                        Navigator.pushNamed(context, "messageScreen",
                            arguments: {
                              "chatID": getChats()[index].chat_id,
                              "usr_img": getChats()[index].user_image,
                              "name": getChats()[index].user_name,
                              "with_id": getChats()[index].with_id
                            });
                      },
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            getChats()[index].user_image,
                            fit: BoxFit.cover,
                          )),
                      title: Text(
                        getChats()[index].user_name,
                        style: TextStyle(fontFamily: 'Bold'),
                      ),
                      subtitle: Text("Location"),
                      trailing: Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        child: Text(
                          "20",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                      ),
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
