import 'package:flutter/material.dart';
import 'package:little_paws/colors.dart';

class UserCategory extends StatefulWidget {
  const UserCategory({Key? key}) : super(key: key);

  @override
  State<UserCategory> createState() => _UserCategoryState();
}

class _UserCategoryState extends State<UserCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            "assets/user_category_bg.jpg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.7,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              height: 70,
              width: 70,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: theme_color,
                    blurRadius: 12,
                    offset: const Offset(5, 5))
              ], color: theme_color, borderRadius: BorderRadius.circular(200)),
              child: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_forward,
                  size: 50,
                  color: Colors.white,
                ),
              )),
          SizedBox(
            height: 25,
          ),
          Text(
            "Choose the Right Category",
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "createProfile");
                },
                child: Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Center(
                    child: Text(
                      "Individual",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: theme_color,
                    borderRadius: const BorderRadius.all(Radius.circular(200)),
                    boxShadow: [
                      BoxShadow(
                          color: theme_color,
                          blurRadius: 12,
                          offset: const Offset(5, 5))
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                   Navigator.pushNamed(context, "shopRegister");
                },
                child: Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Center(
                    child: Text(
                      "Shop Owner",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: theme_color,
                    borderRadius: const BorderRadius.all(Radius.circular(200)),
                    boxShadow: [
                      BoxShadow(
                          color: theme_color,
                          blurRadius: 12,
                          offset: const Offset(5, 5))
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
