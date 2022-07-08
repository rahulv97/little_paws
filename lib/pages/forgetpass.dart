import 'package:flutter/material.dart';
import 'package:little_paws/colors.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({Key? key}) : super(key: key);

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/bg.png",
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: dark_selector,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 80),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Forgot Password",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: dark_selector),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 8),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Enter Your Email To Reset Your Password",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Container(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      labelText: "Email Address",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 231, 231, 231),
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Enter your registered email and we will send you email contains link to reset your password",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: theme_color,
                    borderRadius: const BorderRadius.all(Radius.circular(200)),
                    boxShadow: [
                      BoxShadow(
                          color: theme_color,
                          blurRadius: 12,
                          offset: const Offset(5, 5))
                    ]),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.white, fontSize: 17, fontFamily: 'Bold'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
