import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:little_paws/colors.dart';
import 'package:little_paws/pages/addNew.dart';
import 'package:little_paws/pages/editAds.dart';
import 'package:little_paws/pages/message.dart';
import 'package:little_paws/showToast.dart';

class PartnerDetails extends StatefulWidget {
  const PartnerDetails({Key? key}) : super(key: key);

  @override
  State<PartnerDetails> createState() => _PartnerDetailsState();
}

var my_city = "", user_city = "";

var img_url = "",
    pet_name = "",
    breed = "",
    pet_gender = "",
    creation_date = "",
    creation_time = "",
    pet_dob = "",
    pet_type = "",
    pet_weight = "",
    user_id = "",
    price = "",
    user_type = "",
    status = "",
    user_address = "";

var user_img = "",
    first_name = "",
    last_name = "",
    my_image = "",
    my_first = "",
    my_last = "";

var chat_id;

var contect1;

var button_txt = "";

class _PartnerDetailsState extends State<PartnerDetails> {
  @override
  Widget build(BuildContext context) {
    var ad_id, usr;
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    setState(() {
      ad_id = arguments['ad_id'];
      usr = arguments['user_id'];
      contect1 = context;
    });

    getMyData() async {
      DatabaseReference databaseReference =
          await FirebaseDatabase.instance.ref("partners");
      databaseReference
          .child(FirebaseAuth.instance.currentUser!.uid)
          .onValue
          .listen((event) {
        //print(event.snapshot.value.toString());
        setState(() {
          my_image = event.snapshot.child("profilePic").value.toString();
          my_first = event.snapshot.child("first_name").value.toString();
          my_last = event.snapshot.child("last_name").value.toString();
          my_city = event.snapshot.child("city").value.toString();

          //print(first_name);
          //print(user_img);
        });
      });
    }

    getMyData();

    if (usr == FirebaseAuth.instance.currentUser!.uid) {
      setState(() {
        button_txt = "Edit";
      });
    } else {
      setState(() {
        button_txt = "Contact Now";
      });
    }

    Future<void> addChatToSender(String my_id, String with_id, String chatID,
        String currentDateTime, String with_img, with_name) async {
      //ShowToast().showToast("Adding To Sender");
      DatabaseReference firebaseDatabase =
          FirebaseDatabase.instance.ref("users/" + my_id + "/chats/" + with_id);
      await firebaseDatabase
          .set({
            "chatID": chatID,
            "currentDateTime": currentDateTime,
            "with_img": with_img,
            "with_name": with_name,
            "with_city": my_city
          })
          .onError(
              (error, stackTrace) => ShowToast().showToast(error.toString()))
          .then((value) {
            //ShowToast().showToast("Then 2");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessageScreen(
                  chatID: chatID,
                  usr_img: user_img,
                  name: first_name + " " + last_name,
                  with_id: usr,
                ),
              ),
            );
          });
    }

    Future<void> addChat(String my_id, String with_id, String chatID,
        String currentDateTime, String with_img, with_name) async {
      // ShowToast().showToast("Adding To Own");
      DatabaseReference firebaseDatabase =
          FirebaseDatabase.instance.ref("users/" + my_id + "/chats/" + with_id);
      await firebaseDatabase
          .set({
            "chatID": chatID,
            "currentDateTime": currentDateTime,
            "with_img": with_img,
            "with_name": with_name,
            "with_city": user_city
          })
          .onError(
              (error, stackTrace) => ShowToast().showToast(error.toString()))
          .then((value) {
            // ShowToast().showToast("Then 1");
            addChatToSender(with_id, my_id, chatID, currentDateTime, my_image,
                my_first + " " + my_last);
          });
    }

    getUserDetails(var userID) async {
      DatabaseReference databaseReference =
          await FirebaseDatabase.instance.ref("users");
      databaseReference.child(userID).onValue.listen((event) {
        //print(event.snapshot.value.toString());
        setState(() {
          user_img = event.snapshot.child("profilePic").value.toString();
          first_name = event.snapshot.child("first_name").value.toString();
          last_name = event.snapshot.child("last_name").value.toString();
          user_city = event.snapshot.child("city").value.toString();

          //print(first_name);
          //print(user_img);
        });
      });
    }

    checkChat() async {
      DatabaseReference database = FirebaseDatabase.instance
          .ref("users")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child("chats")
          .child(usr);
      DatabaseEvent snapshot = await database.once();
      var val = snapshot.snapshot.value.toString();
      // ShowToast().showToast(val);
      //DataSnapshot snapshot = await databaseReference.once();

      setState(() {
        chat_id = snapshot.snapshot.child("chatID").value.toString();
      });

      if (val == "null") {
        return "false";
      } else {
        return "true";
      }
    }

    //checkChat();

    get_ad_details(var ad_id) async {
      DatabaseReference firebaseDatabase =
          await FirebaseDatabase.instance.ref("partners").child(ad_id);
      firebaseDatabase.onValue.listen((event) {
        setState(() {
          img_url = event.snapshot.child("img_url").value.toString();
          pet_name = event.snapshot.child("pet_name").value.toString();
          breed = event.snapshot.child("breed").value.toString();
          pet_gender = event.snapshot.child("pet_gender").value.toString();
          creation_date =
              event.snapshot.child("creation_date").value.toString();
          creation_time =
              event.snapshot.child("creation_time").value.toString();
          pet_dob = event.snapshot.child("pet_dob").value.toString();
          pet_type = event.snapshot.child("pet_type").value.toString();
          pet_weight = event.snapshot.child("pet_weight").value.toString();
          user_id = event.snapshot.child("user_id").value.toString();
          price = event.snapshot.child("price").value.toString();
          user_type = event.snapshot.child("user_type").value.toString();
          status = event.snapshot.child("ad_status").value.toString();
          user_address = event.snapshot.child("pet_address").value.toString();
        });
        //getUserDetails(event.snapshot.child("user_id").value.toString());
      });
    }

    //get_ad_details(ad_id);
    getUserDetails(usr);
    get_ad_details(ad_id);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.2,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      img_url,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.2,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 30,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(50, 255, 255, 255),
                              borderRadius: BorderRadius.circular(8)),
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      pet_name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "Bold"),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      breed,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Bold"),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₹" + price,
                          style: TextStyle(
                              color: theme_color,
                              fontSize: 35,
                              fontFamily: "Bold"),
                          textAlign: TextAlign.left,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (usr == FirebaseAuth.instance.currentUser!.uid) {
                              //ShowToast().showToast("Editing");
                              // Navigator.pushNamed(context, "editAd",
                              //     arguments: {
                              //       "ad_id": ad_id,
                              //       "pet_name": pet_name,
                              //       "pet_type": pet_type,
                              //       "breed": breed,
                              //       "dob": pet_dob,
                              //       "gender": pet_gender,
                              //       "weight": pet_weight,
                              //       "img_url": img_url,
                              //       "price": price,
                              //       "ad_status": status
                              //     });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditAd(
                                            pet_name: pet_name,
                                            ad_id: ad_id,
                                            pet_type: pet_type,
                                            breed: breed,
                                            dob: pet_dob,
                                            gender: pet_gender,
                                            weight: pet_weight,
                                            img_url: img_url,
                                            price: price,
                                            ad_status: status,
                                          )));
                            } else {
                              checkChat().then((value) {
                                // ShowToast().showToast(value);
                                if (value == "true") {
                                  Navigator.pushNamed(contect1, "messageScreen",
                                      arguments: {
                                        "chatID": chat_id,
                                        "usr_img": user_img,
                                        "name": first_name + " " + last_name,
                                        "with_id": usr
                                      });
                                } else {
                                  var chatID = usr +
                                      FirebaseAuth.instance.currentUser!.uid;
                                  var currentDateTime = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();

                                  addChat(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      usr,
                                      chatID,
                                      currentDateTime,
                                      user_img,
                                      first_name + " " + last_name);
                                }
                              });
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                                color: theme_color,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(200)),
                                boxShadow: [
                                  BoxShadow(
                                      color: theme_color,
                                      blurRadius: 12,
                                      offset: const Offset(5, 5))
                                ]),
                            child: Text(
                              button_txt,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Bold'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          user_address,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Details",
                  style: TextStyle(
                      color: Colors.black, fontSize: 20, fontFamily: "Bold"),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Type",
                      style: TextStyle(
                          color: Colors.grey, fontSize: 16, fontFamily: "Bold"),
                    ),
                    const Text(
                      "Date of Birth",
                      style: TextStyle(
                          color: Colors.grey, fontSize: 16, fontFamily: "Bold"),
                    ),
                    const Text(
                      "Gender",
                      style: TextStyle(
                          color: Colors.grey, fontSize: 16, fontFamily: "Bold"),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pet_type,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      pet_dob,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      pet_gender,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Weight",
                  style: TextStyle(
                      color: Colors.grey, fontSize: 16, fontFamily: "Bold"),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  pet_weight + " Kg",
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: const Text(
                  "User Details",
                  style: TextStyle(
                      color: Colors.black, fontSize: 20, fontFamily: "Bold"),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            user_img,
                            fit: BoxFit.cover,
                          )),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text(
                          first_name + " " + last_name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Bold"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "(" + user_type + ")",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Bold"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          )
        ],
      ),
    );
  }
}
