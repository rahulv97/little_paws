import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:little_paws/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:little_paws/pages/addNew.dart';
import 'package:little_paws/pages/createProfile.dart';
import 'package:little_paws/pages/detailsPage.dart';

import '../showToast.dart';

bool booll = true;

File? imgFile;

var context1;

var type = "";
var swithc;
var day = "";
var month = "";
var year = "";
var pet_gender;
var image_url_val = "";
var adID = "";

class EditAd extends StatefulWidget {
  final String? pet_name,
      ad_id,
      pet_type,
      breed,
      dob,
      gender,
      weight,
      img_url,
      price,
      ad_status;
  const EditAd(
      {Key? key,
      this.pet_name,
      this.ad_id,
      this.pet_type,
      this.breed,
      this.dob,
      this.gender,
      this.weight,
      this.img_url,
      this.price,
      this.ad_status})
      : super(key: key);

  @override
  State<EditAd> createState() => _EditAdState();
}

TextEditingController name_controller = TextEditingController();
TextEditingController breed_controller = TextEditingController();
TextEditingController weight_controller = TextEditingController();
TextEditingController price_controller = TextEditingController();

class _EditAdState extends State<EditAd> {
// final arguments = (ModalRoute.of(context)?.settings.arguments ??
//         <String, dynamic>{}) as Map;

  void initState() {
    // TODO: implement initState

    setState(() {
      image_url_val = widget.img_url!;
      name_controller.text = widget.pet_name!;
      breed_controller.text = widget.breed!;
      weight_controller.text = widget.weight!;
      price_controller.text = widget.price!;
      type = widget.pet_type!;
      day = widget.dob!.split("-")[0];
      month = widget.dob!.split("-")[1];
      year = widget.dob!.split("-")[2];
      pet_gender = widget.gender!;
      if (widget.ad_status == "true") {
        swithc = true;
      } else {
        swithc = false;
      }
      adID = widget.ad_id!;
    });
    super.initState();
  }

  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);

    try {
      var snap = await firebase_storage.FirebaseStorage.instance
          .ref('advertisement_images/' +
              FirebaseAuth.instance.currentUser!.uid +
              '/' +
              adID +
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

  Future<void> add_data(value) async {
    ShowToast().showToast("Confirm Upload");
    DatabaseReference firebaseDatabase =
        FirebaseDatabase.instance.ref("advertisements/" + adID);

    await firebaseDatabase.update({"pet_name": name_controller.text});

    await firebaseDatabase.update({
      "pet_dob": day.toString() + "-" + month.toString() + "-" + year.toString()
    });

    await firebaseDatabase.update({"pet_gender": pet_gender.toString()});

    await firebaseDatabase.update({"pet_weight": weight_controller.text});

    if (value != "abc") {
      await firebaseDatabase.update({"img_url": value});
    }

    await firebaseDatabase.update({"price": price_controller.text});

    await firebaseDatabase.update({"pet_type": type.toString()});

    await firebaseDatabase.update({"breed": breed_controller.text});

    await firebaseDatabase.update({"ad_status": swithc.toString()});

    setState(() {
      booll = true;
    });

    Navigator.pushReplacementNamed(context1, "dashboard");
  }

  @override
  Widget build(BuildContext context) {
    Image hello() {
      Image image = Image.asset(
        "assets/upload_img_dum.png",
        height: 175,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      );
      if (imgFile == null) {
        image = Image.network(
          image_url_val,
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
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Edit Your Add",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mark as sold out!",
                      style: TextStyle(color: theme_color, fontFamily: 'Bold'),
                    ),
                    Switch(
                      value: swithc,
                      onChanged: (value) {
                        setState(() {
                          swithc = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: name_controller,
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
                    value: type,
                    onChanged: (value) {
                      setState(() {
                        type = value.toString();
                      });
                    },
                    hint: Text("Pet Type"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: breed_controller,
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
                          hint: Text("day"),
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
                    value: pet_gender,
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
                        pet_gender = value.toString();
                      });
                    },
                    hint: Text("Gender"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: weight_controller,
                  keyboardType: TextInputType.number,
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
                  controller: price_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Price (₹)",
                      labelText: "Price (₹)"),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    context1 = context;
                    if (imgFile == null) {
                      if (name_controller.text == "" ||
                          name_controller.text == null) {
                        ShowToast().showToast("Pet Name is required");
                      } else if (breed_controller.text == "" ||
                          breed_controller.text == null) {
                        ShowToast().showToast("Pet Breed is required");
                      } else if (weight_controller.text == "" ||
                          weight_controller.text == null) {
                        ShowToast().showToast("Pet Weight is required");
                      } else if (price_controller.text == "" ||
                          price_controller.text == null) {
                        ShowToast().showToast("Price is required");
                      } else {
                        setState(() {
                          booll = false;
                        });
                        add_data("abc");
                        ShowToast().showToast("Updating Your Ad");
                      }
                    } else {
                      if (name_controller.text == "" ||
                          name_controller.text == null) {
                        ShowToast().showToast("Pet Name is required");
                      } else if (breed_controller.text == "" ||
                          breed_controller.text == null) {
                        ShowToast().showToast("Pet Breed is required");
                      } else if (weight_controller.text == "" ||
                          weight_controller.text == null) {
                        ShowToast().showToast("Pet Weight is required");
                      } else if (price_controller.text == "" ||
                          price_controller.text == null) {
                        ShowToast().showToast("Price is required");
                      } else {
                        setState(() {
                          booll = false;
                        });
                        uploadFile(imgFile!.path);
                        ShowToast().showToast("Updating Your Ad");
                      }
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
                      "Update",
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
}
