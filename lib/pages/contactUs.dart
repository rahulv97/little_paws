import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/bg.png", fit: BoxFit.cover),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back)),
                    SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Contact Us",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'Bold'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                GestureDetector(
                  onTap: () {
                    //Open Email
                    launch("mailto:info@littlepaws.com");
                  },
                  child: Container(
                      padding: EdgeInsets.all(15),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 225, 232, 254),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "assets/prof_msg.png",
                        width: 50,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    //Email
                    launch("mailto:info@littlepaws.com");
                  },
                  child: Text(
                    "info@littlepaws.com",
                    style: TextStyle(
                        color: Colors.black, fontSize: 20, fontFamily: 'Bold'),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    //Open Call
                    launch("tel://+9118001028080");
                  },
                  child: Container(
                      padding: EdgeInsets.all(15),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 237, 189),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "assets/prof_call.png",
                        width: 35,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    //Phone
                    launch("tel://+9118001028080");
                  },
                  child: Text(
                    "+91 1800 102 8080",
                    style: TextStyle(
                        color: Colors.black, fontSize: 20, fontFamily: 'Bold'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
