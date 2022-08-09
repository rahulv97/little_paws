import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_paws/colors.dart';
import 'package:little_paws/pages/addPartnerData.dart';
import 'package:little_paws/pages/myPartnersAd.dart';

class PartnersHome extends StatefulWidget {
  const PartnersHome({Key? key}) : super(key: key);

  @override
  State<PartnersHome> createState() => _PartnersHomeState();
}

class _PartnersHomeState extends State<PartnersHome> {
  String? breed = '';
  var style_val;
  var gender;

  int searchRange = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.png"), fit: BoxFit.cover)),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Partners",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyPartnerAd()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                              color: theme_color,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: theme_color,
                                    blurRadius: 12,
                                    offset: const Offset(5, 5))
                              ]),
                          child: const Text(
                            "Show My Ad",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: 'Bold'),
                          ),
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddnewPartnerData()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.redAccent.withOpacity(0.5),
                                    blurRadius: 12,
                                    offset: const Offset(5, 5))
                              ]),
                          child: const Text(
                            "Add My Pet",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: 'Bold'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 12,
                              offset: const Offset(5, 5))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 45,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: theme_color.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: DropdownButton(
                                  itemHeight: 50,
                                  isExpanded: true,
                                  underline: Container(height: 0),
                                  icon: const Icon(
                                      Icons.arrow_drop_down_circle_outlined),
                                  iconSize: 25,
                                  elevation: 16,
                                  value: style_val,
                                  items: <String>[
                                    'Dog',
                                    'Cat',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      style_val = value.toString();
                                    });
                                  },
                                  hint: Text("Pet Type"),
                                ),
                              ),
                              Container(
                                height: 45,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: theme_color.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: DropdownButton(
                                  itemHeight: 50,
                                  isExpanded: true,
                                  underline: Container(height: 0),
                                  icon: Icon(
                                      Icons.arrow_drop_down_circle_outlined),
                                  iconSize: 25,
                                  elevation: 16,
                                  value: gender,
                                  items: <String>['Male', 'Female']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value.toString();
                                    });
                                  },
                                  hint: Text("Gender"),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: TextField(
                                onChanged: (value) {
                                  breed = value;
                                },
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    labelText: "Breed"),
                              ),
                            ),
                          ),
                          const Center(
                            child: Text(
                              "Search Distance",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Bold'),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                const Text(
                                  "0km",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Bold'),
                                ),
                                Slider(
                                  value: searchRange.toDouble(),
                                  onChanged: (value) {
                                    setState(() {
                                      searchRange = value.toInt();
                                    });
                                  },
                                  min: 0,
                                  max: 100,
                                ),
                                const Text(
                                  "100km",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Bold'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Container(
                              height: 40,
                              width: 140,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  )),
                              child: Center(
                                child: Text(
                                  "Search Range: " + searchRange.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: CupertinoButton(
                              onPressed: () {},
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                    color: theme_color,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: theme_color,
                                          blurRadius: 12,
                                          offset: const Offset(5, 5)),
                                    ]),
                                child: const Text(
                                  "Search",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'Bold'),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
