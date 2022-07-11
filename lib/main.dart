import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:little_paws/onboarding/onboarding1.dart';
import 'package:little_paws/onboarding/onboarding2.dart';
import 'package:little_paws/onboarding/onboarding3.dart';
import 'package:little_paws/pages/allAds.dart';
import 'package:little_paws/pages/createProfile.dart';
import 'package:little_paws/pages/dashboard.dart';
import 'package:little_paws/pages/detailsPage.dart';
import 'package:little_paws/pages/editAds.dart';
import 'package:little_paws/pages/favourites.dart';
import 'package:little_paws/pages/forgetpass.dart';
import 'package:little_paws/pages/loginScreen.dart';
import 'package:little_paws/pages/message.dart';
import 'package:little_paws/pages/registerScreen.dart';
import 'package:little_paws/pages/shopRegister.dart';
import 'package:little_paws/pages/splashScreen.dart';
import 'package:little_paws/pages/userCategory.dart';
import 'package:little_paws/theme_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (FirebaseAuth.instance.currentUser == null) {
    runApp(const MyApp());
  } else {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("users");

    databaseReference.onValue.listen((event) {
      if (event.snapshot.child(FirebaseAuth.instance.currentUser!.uid).exists) {
        runApp(const MyApp1());
      } else {
        runApp(const MyApp2());
      }
    });
  }
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Little Paws',
      theme: ThemeData(
        primarySwatch: Palette.themeColor,
      ),
      home: const SplashScreen(),
      routes: {
        "onboard1": (context) => const OnBoarding1(),
        "onboard2": (context) => const OnBoarding2(),
        "onboard3": (context) => const OnBoarding3(),
        "login": (context) => const LoginScreen(),
        "register": (context) => const RegisterScreen(),
        "forgetPass": (context) => const ForgetPass(),
        "user_category": (context) => const UserCategory(),
        "createProfile": (context) => const CreateProfile(),
        "shopRegister": (context) => const ShopRegister(),
        "dashboard": (context) => const Dashboard(),
        "details": ((context) => const DetailsPage()),
        "messageScreen": (context) => const MessageScreen(),
        "editAd":(context) => const EditAd(),
        "allAds":(context) => const AllAds(),
        "favourites":(context) => const Favourites(),
      },
    );
  }
}

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Little Paws',
      theme: ThemeData(
        primarySwatch: Palette.themeColor,
      ),
      home: const Dashboard(),
      routes: {
        "onboard1": (context) => const OnBoarding1(),
        "onboard2": (context) => const OnBoarding2(),
        "onboard3": (context) => const OnBoarding3(),
        "login": (context) => const LoginScreen(),
        "register": (context) => const RegisterScreen(),
        "forgetPass": (context) => const ForgetPass(),
        "user_category": (context) => const UserCategory(),
        "createProfile": (context) => const CreateProfile(),
        "shopRegister": (context) => const ShopRegister(),
        "dashboard": (context) => const Dashboard(),
        "details": ((context) => const DetailsPage()),
        "messageScreen": (context) => const MessageScreen(),
        "editAd":(context) => const EditAd(),
        "allAds":(context) => const AllAds(),
        "favourites":(context) => const Favourites(),
      },
    );
  }
}

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Little Paws',
      theme: ThemeData(
        primarySwatch: Palette.themeColor,
      ),
      home: const UserCategory(),
      routes: {
        "onboard1": (context) => const OnBoarding1(),
        "onboard2": (context) => const OnBoarding2(),
        "onboard3": (context) => const OnBoarding3(),
        "login": (context) => const LoginScreen(),
        "register": (context) => const RegisterScreen(),
        "forgetPass": (context) => const ForgetPass(),
        "user_category": (context) => const UserCategory(),
        "createProfile": (context) => const CreateProfile(),
        "shopRegister": (context) => const ShopRegister(),
        "dashboard": (context) => const Dashboard(),
        "details": ((context) => const DetailsPage()),
        "messageScreen": (context) => const MessageScreen(),
        "editAd":(context) => const EditAd(),
        "allAds":(context) => const AllAds(),
        "favourites":(context) => const Favourites(),
      },
    );
  }
}
