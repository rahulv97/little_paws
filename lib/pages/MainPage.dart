import 'dart:ui';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:little_paws/colors.dart';
import 'package:little_paws/pages/addNew.dart';
import 'package:little_paws/pages/chatScreen.dart';
import 'package:little_paws/pages/editPage.dart';
import 'package:little_paws/pages/favourites.dart';
import 'package:little_paws/pages/homePage.dart';
import 'package:little_paws/pages/ind_editProfile.dart';
import 'package:little_paws/pages/myProfile.dart';
import 'package:little_paws/showToast.dart';
import 'package:little_paws/theme_color.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

int index = 0;

var cont;

class GoTo {
  void goto(int tab) {
    DefaultTabController.of(cont)!.animateTo(tab);
  }
}

class _MainPageState extends State<MainPage> {
  late TabController _tabController;
  @override
  void initState() {
    setState(() {
      cont = context;
    });
    // TODO: implement initState
    super.initState();
  }

  var myMenuItems = <String>[
    'Setting',
    'Sign Out',
  ];

  void onSelect(item) {
    switch (item) {
      case 'Setting':
        if (user_type == "ShopOwner") {
          Navigator.pushNamed(context, "ind_editProfile",
              arguments: {"type": "ShopOwner"});
        } else {
          Navigator.pushNamed(context, "ind_editProfile",
              arguments: {"type": "Individual"});
        }
        break;
      case 'Sign Out':
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, "login");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    int _selectedItemPosition = 0;

    return DefaultTabController(
      initialIndex: index,
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: Icons.home_outlined),
            TabItem(icon: Icons.chat_bubble_outline_outlined),
            TabItem(icon: Icons.favorite_border_outlined),
            TabItem(icon: Icons.edit_calendar_outlined),
            TabItem(icon: Icons.person_outline),
          ],
          backgroundColor: Colors.white,
          activeColor: Palette.themeColor,
          color: Palette.themeColor,
        ),
        appBar: AppBar(
          toolbarHeight: 60,
          title: Text(
            "Little Paws",
            style: TextStyle(
                fontSize: 22, color: Colors.black, fontFamily: 'Bold'),
          ),
          leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                "assets/menu_ic.png",
                height: 35,
              ),
            ),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "searchScreen");
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                            color: Color.fromARGB(15, 0, 0, 0),
                            blurRadius: 4,
                            offset: Offset(4, 4))
                      ],
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.search,
                          color: theme_color,
                        ))),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(
                        color: Color.fromARGB(15, 0, 0, 0),
                        blurRadius: 4,
                        offset: Offset(4, 4))
                  ],
                ),
                child: PopupMenuButton<String>(
                    onSelected: onSelect,
                    icon: Icon(
                      Icons.more_vert,
                      color: theme_color,
                    ),
                    itemBuilder: (BuildContext context) {
                      return myMenuItems.map((String choice) {
                        return PopupMenuItem<String>(
                          child: Text(choice),
                          value: choice,
                        );
                      }).toList();
                    }),
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: TabBarView(
          children: [
            HomePage(),
            ChatScreen(),
            Favourites(),
            EditPage(),
            MyProfile()
          ],
        ),
      ),
    );
  }
}
