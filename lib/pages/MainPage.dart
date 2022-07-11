import 'dart:ui';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:little_paws/colors.dart';
import 'package:little_paws/pages/addNew.dart';
import 'package:little_paws/pages/chatScreen.dart';
import 'package:little_paws/pages/editPage.dart';
import 'package:little_paws/pages/homePage.dart';
import 'package:little_paws/pages/myProfile.dart';
import 'package:little_paws/showToast.dart';
import 'package:little_paws/theme_color.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedItemPosition = 0;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: Icons.home_outlined),
            TabItem(icon: Icons.chat_bubble_outline_outlined),
            TabItem(icon: Icons.add_box_outlined),
            TabItem(icon: Icons.edit_calendar_outlined),
            TabItem(icon: Icons.person_outline),
          ],
          backgroundColor: Colors.white,
          activeColor: Palette.themeColor,
          color: Palette.themeColor,
        ),
        appBar: AppBar(
          toolbarHeight: 60,
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
                Navigator.pushNamed(context, "favourites");
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
                          Icons.favorite,
                          color: theme_color,
                        ))),
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: TabBarView(
          children: [
            HomePage(),
            ChatScreen(),
            AddnewAd(),
            EditPage(),
            MyProfile()
          ],
        ),
      ),
    );
  }
}
