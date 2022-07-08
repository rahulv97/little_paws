import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:little_paws/colors.dart';
import 'package:little_paws/pages/addNew.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class Advertisements {
  String image_url,
      pet_name,
      breed,
      gender,
      add_id,
      creation_date,
      creation_time,
      pet_dob,
      pet_type,
      weight,
      user_id,
      user_type,
      price;
  Advertisements(
      {required this.image_url,
      required this.pet_name,
      required this.breed,
      required this.gender,
      required this.add_id,
      required this.creation_date,
      required this.creation_time,
      required this.pet_dob,
      required this.pet_type,
      required this.weight,
      required this.user_id,
      required this.user_type,
      required this.price});
}

List<Advertisements> advertisements = [];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    getAds() {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("advertisements");

      databaseReference.onValue.listen((event) {
        advertisements.clear();
        for (var data in event.snapshot.children) {
          var gend;
          if (data.child("pet_gender").value.toString() == "Male") {
            gend = "assets/male_ic.png";
            //print(gend);
          } else {
            gend = "assets/female_ic.png";
            // print(gend);
          }

          if (data.child("ad_status").value.toString() == "true") {
          } else {
            advertisements.add(Advertisements(
                image_url: data.child("img_url").value.toString(),
                pet_name: data.child("pet_name").value.toString(),
                breed: data.child("breed").value.toString(),
                gender: gend,
                add_id: data.child("ad_id").value.toString(),
                creation_date: data.child("creation_date").value.toString(),
                creation_time: data.child("creation_time").value.toString(),
                pet_dob: data.child("pet_dob").value.toString(),
                pet_type: data.child("pet_type").value.toString(),
                weight: data.child("pet_weight").value.toString(),
                user_id: data.child("user_id").value.toString(),
                user_type: data.child("user_type").value.toString(),
                price: data.child("price").value.toString()));
          }
        }
        setState(() {
          advertisements = advertisements.reversed.toList();
        });

        // print("Ads: " + advertisements[0].pet_dob);
      });
      return advertisements;
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Little Paws",
              style: TextStyle(
                  fontSize: 24, color: Colors.black, fontFamily: 'Bold'),
            ),
            const Text(
              "Pet Brings Happiness",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(35, 0, 0, 0),
                        blurRadius: 12,
                        offset: Offset(8, 8))
                  ]),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search',
                    fillColor: Colors.transparent,
                    filled: true,
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/search_bar_ic.png",
                        height: 5,
                      ),
                    )),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 254, 243, 222),
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 3, bottom: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/buy_filter.png",
                        height: 18,
                      ),
                      const Text(
                        "  Buy",
                      )
                    ],
                  ),
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 226, 233, 254),
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 3, bottom: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/sell_filter.png",
                        height: 18,
                      ),
                      const Text("  Sell")
                    ],
                  ),
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 255, 223),
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 3, bottom: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/partner_filter.png",
                        height: 18,
                      ),
                      const Text("  Partner")
                    ],
                  ),
                ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Popular",
                        style: TextStyle(fontSize: 20, fontFamily: 'Bold')),
                    Row(
                      children: [
                        const Text(
                          "View All",
                          style: TextStyle(fontFamily: 'Bold'),
                        ),
                        Image.asset(
                          "assets/view_all.png",
                          height: 28,
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                  //shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 3 / 4),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(6),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              const BoxShadow(
                                color: Color.fromARGB(50, 0, 0, 0),
                                blurRadius: 5,
                              ),
                            ]),
                        child: Column(children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 7,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                  child: Image.network(
                                    advertisements[index].image_url,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(500),
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      color: theme_color,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, left: 15, right: 15),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 238, 234, 251),
                                    borderRadius: BorderRadius.circular(150)),
                                child: Text(
                                  advertisements[index].pet_type,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 156, 139, 203),
                                      fontSize: 12),
                                ),
                              ),
                              Image.asset(
                                "assets/location.png",
                                height: 18,
                              ),
                              Image.asset(
                                advertisements[index].gender,
                                height: 18,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                              padding: const EdgeInsets.only(left: 15),
                              alignment: Alignment.topLeft,
                              child: Text(
                                advertisements[index].pet_name,
                                style: const TextStyle(
                                    fontSize: 16, fontFamily: 'Bold'),
                              )),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(getAds()[index].breed),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, "details", arguments: {
                                    "ad_id": advertisements[index].add_id,
                                    "user_id": advertisements[index].user_id
                                  }),
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 20,
                                          right: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(500),
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                theme_color,
                                                const Color.fromARGB(
                                                    255, 250, 208, 102)
                                              ])),
                                      child: const Text(
                                        "View",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                )
                              ],
                            ),
                          )
                        ]),
                      ),
                    );
                  },
                  itemCount: getAds().length,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
