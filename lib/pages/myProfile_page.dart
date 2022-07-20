import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
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

class _MyProfilePageState extends State<MyProfilePage> {
  String profile_img_url = "";
  String first_name_person = "";
  String last_name_person = "";
  String city_person = "";
  String country_person = "";
  String user_type = "";
  String usr = "";

  getProfile() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref("users/" + FirebaseAuth.instance.currentUser!.uid);
    await databaseReference.onValue.listen((event) {
      profile_img_url = event.snapshot.child("profilePic").value.toString();
      first_name_person = event.snapshot.child("first_name").value.toString();
      last_name_person = event.snapshot.child("last_name").value.toString();
      city_person = event.snapshot.child("city").value.toString();
      country_person = event.snapshot.child("country").value.toString();
      user_type = event.snapshot.child("user_type").value.toString();
      if (user_type == "ShopOwner") {
        usr = " (" + "Shop Owner" + ")";
      }
      // ShowToast().showToast(profile_img_url);
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  Image hello() {
    //getProfile();
    Image image = Image.asset(
      "assets/prof_pic.jpg",
      height: 125,
      width: 125,
      fit: BoxFit.cover,
    );
    if (profile_img_url.isEmpty) {
      image = Image.asset(
        "assets/prof_pic.jpg",
        height: 125,
        width: 125,
        fit: BoxFit.cover,
      );
    } else {
      image = Image.network(
        profile_img_url,
        height: 125,
        width: 125,
        fit: BoxFit.cover,
      );
    }

    return image;
  }

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

          if (data.child("user_id").value.toString() ==
              FirebaseAuth.instance.currentUser!.uid) {
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

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xfffFEF0F0),
        ),
        body: Container(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/bg.png",
                fit: BoxFit.cover,
              ),
              ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: hello(),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, right: 20, left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  blurRadius: 8,
                                )
                              ]),
                          child: Column(
                            children: [
                              Text(
                                first_name_person +
                                    " " +
                                    last_name_person +
                                    usr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontFamily: 'Bold'),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                city_person + ", " + country_person,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, right: 20, left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  blurRadius: 8,
                                )
                              ]),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "contactUs");
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 225, 232, 254),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.asset(
                                        "assets/prof_msg.png",
                                        width: 35,
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "catAds");
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 237, 189),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.asset(
                                        "assets/sell_filter.png",
                                        width: 35,
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "dogAds");
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 226, 233, 254),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.asset(
                                        "assets/buy_filter.png",
                                        width: 35,
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (user_type == "ShopOwner") {
                                      Navigator.pushNamed(
                                          context, "ind_editProfile",
                                          arguments: {"type": "ShopOwner"});
                                    } else {
                                      Navigator.pushNamed(
                                          context, "ind_editProfile",
                                          arguments: {"type": "Individual"});
                                    }
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 237, 189),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.asset(
                                        "assets/prof_set.png",
                                      )),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, right: 20, left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  blurRadius: 8,
                                )
                              ]),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "My Recent Ads",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Bold'),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListView.builder(
                                //scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: ListTile(
                                      leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            advertisements[index].image_url,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          )),
                                      title: Text(
                                        advertisements[index].pet_name,
                                        style: TextStyle(fontFamily: 'Bold'),
                                      ),
                                      subtitle: Text("Created On: " +
                                          advertisements[index]
                                              .creation_date
                                              .replaceAll(":", "-")),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                    ),
                                  );
                                },
                                itemCount: getAds().length,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
