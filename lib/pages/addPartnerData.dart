// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:little_paws/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:little_paws/src/models/pick_result.dart';
import 'package:little_paws/src/place_picker.dart';

import '../showToast.dart';

bool booll = true;

var lat = "";
var long = "";

class AddnewPartnerData extends StatefulWidget {
  const AddnewPartnerData({Key? key}) : super(key: key);

  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  State<AddnewPartnerData> createState() => _AddnewPartnerDataState();
}

var adID;
var style_val;
var day;
var month;
var year;
var gender;
var user_type;

String pet_name = "",
    breed = "",
    pet_type = style_val.toString(),
    pet_dob = day + "-" + month + "-" + year,
    pet_gender = gender,
    pet_weight = "",
    ad_id = adID,
    creation_time = DateTime.now().hour.toString() +
        ":" +
        DateTime.now().minute.toString() +
        ":" +
        DateTime.now().second.toString(),
    creation_date = DateTime.now().day.toString() +
        ":" +
        DateTime.now().month.toString() +
        ":" +
        DateTime.now().year.toString(),
    price = "";

String img_down_url = "";

var context1;

class _AddnewPartnerDataState extends State<AddnewPartnerData> {
  File? imgFile;
  var heading_style =
      TextStyle(color: dark_selector, fontWeight: FontWeight.w800);

  void hello1() {
    var dt = DateTime.now();
    setState(() {
      adID = dt.day.toString() +
          dt.month.toString() +
          dt.year.toString() +
          dt.hour.toString() +
          dt.minute.toString() +
          dt.second.toString() +
          dt.millisecond.toString() +
          dt.microsecond.toString();

      ad_id = adID;
    });

    print(adID);
  }

  getProfile() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref("users/" + FirebaseAuth.instance.currentUser!.uid);
    await databaseReference.onValue.listen((event) {
      user_type = event.snapshot.child("user_type").value.toString();

      // ShowToast().showToast(profile_img_url);
      setState(() {});
    });
  }

  Image hello() {
    Image image = Image.asset(
      "assets/upload_img_dum.png",
      height: 175,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
    if (imgFile == null) {
      image = Image.asset(
        "assets/upload_img_dum.png",
        height: 175,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      );
    } else {
      image = Image.file(
        imgFile!,
        height: 175,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      );
    }
    return image;
  }

  PickResult? selectedPlace;

  TextEditingController pet_address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> add_data(value) async {
      DatabaseReference firebaseDatabase =
          FirebaseDatabase.instance.ref("partners/" + ad_id);
      await firebaseDatabase.set({
        "pet_name": pet_name,
        "pet_type": pet_type,
        "breed": breed,
        "pet_dob": pet_dob,
        "pet_gender": pet_gender,
        "pet_weight": pet_weight,
        "ad_id": ad_id,
        "creation_time": creation_time,
        "creation_date": creation_date,
        "img_url": value,
        "user_id": FirebaseAuth.instance.currentUser!.uid,
        "user_type": user_type,
        "price": price,
        "pet_address": selectedPlace!.formattedAddress,
        "pet_address_lat": lat,
        "pet_address_long": long,
      }).onError((error, stackTrace) {
        setState(() {
          booll = true;
        });
        ShowToast().showToast(error.toString());
      }).then((value) {
        setState(() {
          booll = true;
        });
        Navigator.pushReplacementNamed(context1, "dashboard");
      });
    }

    Future<void> uploadFile(String filePath) async {
      File file = File(filePath);

      try {
        var snap = await firebase_storage.FirebaseStorage.instance
            .ref('partner_images/' +
                FirebaseAuth.instance.currentUser!.uid +
                '/' +
                ad_id +
                '.png')
            .putFile(file);

        await snap.ref
            .getDownloadURL()
            .then((value) => add_data(value))
            .onError((error, stackTrace) {
          setState(() {
            booll = true;
          });
        });
      } catch (e) {
        setState(() {
          booll = true;
        });
        // e.g, e.code == 'canceled'
      }
    }

    void getLatandLong() async {
      GeoData data = await Geocoder2.getDataFromAddress(
          address: "${selectedPlace!.formattedAddress}",
          googleMapApiKey: "AIzaSyAa2r0evELr-zQULo0zw-uiAYw1dqjV2Co");
      setState(() {
        lat = "${data.latitude}";
        long = "${data.longitude}";
      });
    }

    getProfile();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/bg.png", fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back)),
                    const SizedBox(width: 40),
                    Text(
                      "Add For Partner",
                      style: TextStyle(
                          color: dark_selector,
                          fontSize: 25,
                          fontFamily: 'Bold'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 175,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(24, 0, 0, 0),
                            blurRadius: 3,
                          )
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GestureDetector(
                          onTap: () {
                            _getFromGallery();
                          },
                          child: hello()),
                    )),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  onChanged: (value) {
                    pet_name = value;
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Your Pet Name",
                      labelText: "Pet Name"),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Type Of Pet",
                  style: TextStyle(color: dark_selector, fontFamily: 'Bold'),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(24, 0, 0, 0),
                          blurRadius: 3,
                        )
                      ]),
                  child: DropdownButton(
                    itemHeight: 50,
                    isExpanded: true,
                    underline: Container(height: 0),
                    icon: Icon(Icons.arrow_drop_down_circle_outlined),
                    iconSize: 25,
                    elevation: 16,
                    value: style_val,
                    items: <String>[
                      'Dog',
                      'Cat',
                    ].map<DropdownMenuItem<String>>((String value) {
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
                        style_val = value.toString();
                      });
                    },
                    hint: Text("Pet Type"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  onChanged: (value) {
                    breed = value;
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Breed",
                      labelText: "Breed"),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Birthdate",
                  style: TextStyle(color: dark_selector, fontFamily: 'Bold'),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(24, 0, 0, 0),
                                blurRadius: 3,
                              )
                            ]),
                        child: DropdownButton(
                          itemHeight: 50,
                          isExpanded: true,
                          underline: Container(height: 0),
                          icon: Icon(Icons.arrow_drop_down_circle_outlined),
                          iconSize: 25,
                          elevation: 16,
                          value: day,
                          items: <String>[
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '7',
                            "8",
                            "9",
                            "10",
                            "11",
                            "12",
                            "13",
                            "14",
                            "15",
                            "16",
                            "17",
                            "18",
                            "19",
                            "20",
                            "21",
                            "22",
                            "23",
                            "24",
                            "25",
                            "26",
                            "27",
                            "28",
                            "29",
                            "30",
                            "31",
                          ].map<DropdownMenuItem<String>>((String value) {
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
                              day = value.toString();
                            });
                          },
                          hint: Text("Day"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(24, 0, 0, 0),
                                blurRadius: 3,
                              )
                            ]),
                        child: DropdownButton(
                          itemHeight: 50,
                          isExpanded: true,
                          underline: Container(height: 0),
                          icon: Icon(Icons.arrow_drop_down_circle_outlined),
                          iconSize: 25,
                          elevation: 16,
                          value: month,
                          items: <String>[
                            'January',
                            'February',
                            'March',
                            'April',
                            'May',
                            'June',
                            'July',
                            "August",
                            "September",
                            "October",
                            "November",
                            "December"
                          ].map<DropdownMenuItem<String>>((String value) {
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
                              month = value.toString();
                            });
                          },
                          hint: Text("Month"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(24, 0, 0, 0),
                                blurRadius: 3,
                              )
                            ]),
                        child: DropdownButton(
                          itemHeight: 50,
                          isExpanded: true,
                          underline: Container(height: 0),
                          icon: Icon(Icons.arrow_drop_down_circle_outlined),
                          iconSize: 25,
                          elevation: 16,
                          value: year,
                          items: <String>[
                            '2001',
                            '2002',
                            '2003',
                            '2004',
                            '2005',
                            '2006',
                            '2007',
                            "2008",
                            "2009",
                            "2010",
                            "2011",
                            "2012",
                            "2013",
                            "2014",
                            "2015",
                            "2016",
                            "2017",
                            "2018",
                            "2019",
                            "2020",
                            "2021",
                            "2022"
                          ].map<DropdownMenuItem<String>>((String value) {
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
                              year = value.toString();
                            });
                          },
                          hint: Text("Year"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Gender",
                  style: TextStyle(color: dark_selector, fontFamily: 'Bold'),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(24, 0, 0, 0),
                          blurRadius: 3,
                        )
                      ]),
                  child: DropdownButton(
                    itemHeight: 50,
                    isExpanded: true,
                    underline: Container(height: 0),
                    icon: Icon(Icons.arrow_drop_down_circle_outlined),
                    iconSize: 25,
                    elevation: 16,
                    value: gender,
                    items: <String>['Male', 'Female']
                        .map<DropdownMenuItem<String>>((String value) {
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
                SizedBox(
                  height: 15,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    pet_weight = value;
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Weight (KG)",
                      labelText: "Weight (KG)"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    price = value;
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Price (₹)",
                      labelText: "Price (₹)"),
                ),
                SizedBox(
                  height: 15,
                ),
                selectedPlace == null
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(selectedPlace!.formattedAddress ?? ""),
                        ),
                      ),
                Container(
                  padding: EdgeInsets.only(
                    left: 60,
                    right: 60,
                  ),
                  child: CupertinoButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PlacePicker(
                              apiKey: "AIzaSyAa2r0evELr-zQULo0zw-uiAYw1dqjV2Co",
                              initialPosition:
                                  AddnewPartnerData.kInitialPosition,
                              useCurrentLocation: true,
                              selectInitialPosition: true,
                              onPlacePicked: (result) {
                                selectedPlace = result;
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                            );
                          },
                        ),
                      ).then((value) => getLatandLong());
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: theme_color,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: theme_color,
                                blurRadius: 2,
                                offset: const Offset(1, 1))
                          ]),
                      child: const Text(
                        "Add Address",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Bold'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    context1 = context;
                    hello1();

                    if (imgFile == null) {
                      ShowToast().showToast("Please Select an image");
                    } else if (pet_name.isEmpty) {
                      ShowToast().showToast("Pet Name is Required");
                    } else if (breed.isEmpty) {
                      ShowToast().showToast("Breed is Required");
                    } else if (pet_weight.isEmpty) {
                      ShowToast().showToast("Weight is Required");
                    } else if (pet_type == "null") {
                      ShowToast().showToast("Pet Type is Required");
                    } else if (day == "null") {
                      ShowToast().showToast("Date of Birth is Required");
                    } else if (month == "null") {
                      ShowToast().showToast("Date of Birth is Required");
                    } else if (year == "null") {
                      ShowToast().showToast("Date of Birth is Required");
                    } else if (gender == "null") {
                      ShowToast().showToast("Gender is Required");
                    } else if (selectedPlace?.formattedAddress == null ||
                        selectedPlace?.formattedAddress == "") {
                      ShowToast().showToast("Address is Required");
                    } else {
                      ShowToast().showToast("Uploading Your Ad Please Wait");
                      setState(() {
                        booll = false;
                      });
                      uploadFile(imgFile!.path);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: theme_color,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(200)),
                        boxShadow: [
                          BoxShadow(
                              color: theme_color,
                              blurRadius: 12,
                              offset: const Offset(5, 5))
                        ]),
                    child: const Text(
                      "Submit Ad",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Bold'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
          booll
              ? Container()
              : Container(
                  color: Colors.black.withOpacity(0.7),
                  child: Center(child: CircularProgressIndicator()),
                )
        ],
      ),
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    _cropImage(pickedFile!.path);
  }

  /// Crop Image
  _cropImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    if (croppedImage != null) {
      setState(() {
        imgFile = croppedImage;
      });
    }
  }

  updateAddress(String add) {
    pet_address.text = add;
  }
}
