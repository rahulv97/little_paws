import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:little_paws/colors.dart';
import 'package:little_paws/pages/MainPage.dart';
import 'package:little_paws/showToast.dart';

String profile_img_url = "";
String user_type = "";

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  getProfile() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref("users/" + FirebaseAuth.instance.currentUser!.uid);
    await databaseReference.onValue.listen((event) {
      profile_img_url = event.snapshot.child("profilePic").value.toString();
      //ShowToast().showToast(profile_img_url);
      log("Profile Pic URL: " + profile_img_url);
      setState(() {});
    });
  }

  Image hello() {
    //getProfile();
    Image image = Image.asset(
      "assets/prof_pic.jpg",
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    );
    if (profile_img_url.isEmpty) {
      image = Image.asset(
        "assets/prof_pic.jpg",
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    } else if (profile_img_url == "null") {
      image = Image.asset(
        "assets/prof_pic.jpg",
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    } else {
      image = Image.network(
        profile_img_url,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    }

    return image;
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   getProfile();
    // });
    getProfile() async {
      DatabaseReference databaseReference = FirebaseDatabase.instance
          .ref("users/" + FirebaseAuth.instance.currentUser!.uid);
      await databaseReference.onValue.listen((event) {
        profile_img_url = event.snapshot.child("profilePic").value.toString();

        user_type = event.snapshot.child("user_type").value.toString();
        ;
        setState(() {});
      });
    }

    getProfile();
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Container(
          color: menu_bg,
        ),
        ListView(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 20, right: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ZoomDrawer.of(context)!.toggle();
                      },
                      child: Image.asset(
                        "assets/other.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                    // Image.asset(
                    //   "assets/notification_on.png",
                    //   height: 20,
                    //   width: 20,
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 20),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: GestureDetector(child: hello()),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 20),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, "myProfilePage");
                      },
                      title: Text("Profile"),
                      leading: const Icon(Icons.person),
                      iconColor: Colors.white,
                      textColor: Colors.white,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, "dogAds");
                      },
                      title: const Text("Dog"),
                      leading: Image.asset(
                        "assets/dog_ic.png",
                        height: 25,
                      ),
                      iconColor: Colors.white,
                      textColor: Colors.white,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, "catAds");
                      },
                      title: const Text("Cat"),
                      leading: Image.asset(
                        "assets/cat_ic.png",
                        height: 25,
                      ),
                      iconColor: Colors.white,
                      textColor: Colors.white,
                    ),
                    ListTile(
                      onTap: () => ShowToast().showToast("Coming Soonn..."),
                      title: const Text("Blogs"),
                      leading: Image.asset(
                        "assets/blog_ic.png",
                        height: 25,
                      ),
                      iconColor: Colors.white,
                      textColor: Colors.white,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, "favourites");
                      },
                      title: const Text("Favourite"),
                      leading: const Icon(
                        Icons.favorite,
                        size: 25,
                      ),
                      iconColor: Colors.white,
                      textColor: Colors.white,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, "chatPage");
                      },
                      title: const Text("Message"),
                      leading: Image.asset(
                        "assets/message_ic.png",
                        height: 25,
                      ),
                      iconColor: Colors.white,
                      textColor: Colors.white,
                    ),
                    ListTile(
                      onTap: () {
                        if (user_type == "ShopOwner") {
                          Navigator.pushNamed(context, "ind_editProfile",
                              arguments: {"type": "ShopOwner"});
                        } else {
                          Navigator.pushNamed(context, "ind_editProfile",
                              arguments: {"type": "Individual"});
                        }
                      },
                      title: const Text("Settings"),
                      leading: Image.asset(
                        "assets/setting_ic.png",
                        height: 25,
                      ),
                      iconColor: Colors.white,
                      textColor: Colors.white,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, "contactUs");
                      },
                      title: const Text("Help & Support"),
                      leading: Icon(
                        Icons.help,
                        size: 25,
                      ),
                      iconColor: Colors.white,
                      textColor: Colors.white,
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.white,
                    ),
                    GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(context, "login");
                      },
                      child: const ListTile(
                        title: const Text("Sign Out"),
                        leading: const Icon(
                          Icons.exit_to_app,
                          size: 25,
                        ),
                        iconColor: Colors.white,
                        textColor: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ])
      ]),
    );
  }
}
