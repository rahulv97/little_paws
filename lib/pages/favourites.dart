import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:little_paws/colors.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

Future add_myFav(String fav_id) async {
  DatabaseReference addFavRef = FirebaseDatabase.instance.ref("users/" +
      FirebaseAuth.instance.currentUser!.uid +
      "/favourites/" +
      fav_id);
  await addFavRef.set({fav_id: fav_id});
}

Future rem_fav(String fav_id) async {
  DatabaseReference addFavRef = FirebaseDatabase.instance
      .ref("users/" + FirebaseAuth.instance.currentUser!.uid + "/favourites/");
  await addFavRef.child(fav_id).remove();
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

List<Advertisements> all_ads = [];

List<Advertisements> advertisements = [];

List<String> my_favourits = [];

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    DatabaseReference favDatabase = FirebaseDatabase.instance
        .ref("users/" + FirebaseAuth.instance.currentUser!.uid + "/favourites");
    favDatabase.onValue.listen((event) {
      my_favourits.clear();
      for (var data in event.snapshot.children) {
        my_favourits.add(data.key.toString());
      }
    });
    setState(() {
      my_favourits;
    });
    getAds() {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("advertisements");

      databaseReference.onValue.listen((event) {
        all_ads.clear();
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
            all_ads.add(Advertisements(
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
          all_ads = all_ads.reversed.toList();
          print(all_ads[1].pet_name);
          advertisements.clear();
          for (int i = 0; i < all_ads.length; i++) {
            if (my_favourits.contains(all_ads[i].add_id)) {
              advertisements.add(all_ads[i]);
            } else {
              //fav_color.add(theme_color);
            }
            //fav_color.add(theme_color);
          }
        });

        // print("Ads: " + advertisements[0].pet_dob);
      });
      return advertisements;
    }

    getAds();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              width: 30,
            ),
          )
        ],
        title: Center(
          child: Text(
            "My Favourites",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontFamily: 'Bold',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: GridView.builder(
        shrinkWrap: true,

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
                          child: GestureDetector(
                            onTap: () {
                              rem_fav(advertisements[index].add_id);
                              setState(() {
                                advertisements
                                    .remove(advertisements[index].add_id);
                              });
                            },
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 20,
                            ),
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
                          color: const Color.fromARGB(255, 238, 234, 251),
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
                      style: const TextStyle(fontSize: 16, fontFamily: 'Bold'),
                    )),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(advertisements[index].breed),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "details",
                            arguments: {
                              "ad_id": advertisements[index].add_id,
                              "user_id": advertisements[index].user_id
                            }),
                        child: Container(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 20, right: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      theme_color,
                                      const Color.fromARGB(255, 250, 208, 102)
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
        itemCount: advertisements.length,
      ),
    );
  }
}
