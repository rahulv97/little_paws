import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
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

TextEditingController searchController = TextEditingController();

List<Advertisements> advertisements = [];
List<Advertisements> filteredAds = [];

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    // TODO: implement initState
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

    getAds();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                  child: Icon(Icons.arrow_back),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 47,
                  width: MediaQuery.of(context).size.width - 90,
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
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        filteredAds.clear();
                        for (int i = 0; i < advertisements.length; i++) {
                          if (advertisements[i]
                                  .pet_name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              advertisements[i]
                                  .pet_type
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              advertisements[i]
                                  .gender
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              advertisements[i]
                                  .breed
                                  .toLowerCase()
                                  .contains(value.toLowerCase())) {
                            filteredAds.add(advertisements[i]);
                          }
                        }

                        if (value == "") {
                          filteredAds.clear();
                        }
                      });
                    },
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
              ],
            ),
            ListView.builder(
              //scrollDirection: Axis.vertical,
              shrinkWrap: true,
              //physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "details", arguments: {
                        "ad_id": filteredAds[index].add_id,
                        "user_id": filteredAds[index].user_id
                      });
                    },
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          filteredAds[index].image_url,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )),
                    title: Text(
                      filteredAds[index].pet_name,
                      style: TextStyle(fontFamily: 'Bold'),
                    ),
                    subtitle: Text("Created On: " +
                        filteredAds[index].creation_date.replaceAll(":", "-")),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
              itemCount: filteredAds.length,
            )
          ],
        ),
      ),
    );
  }
}
