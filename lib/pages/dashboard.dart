import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:little_paws/pages/MainPage.dart';
import 'package:little_paws/pages/MenuPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance
        .ref("users/" + FirebaseAuth.instance.currentUser!.uid);
    await firebaseDatabase.update({"status": status});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    if (state == AppLifecycleState.resumed) {
      //Online
      setStatus("Online");
    } else {
      //Offline
      setStatus("Offline");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
      mainScreen: MainPage(),
      menuScreen: MenuPage(),
      angle: 0,
      duration: Duration(milliseconds: 500),
    );
  }
}
