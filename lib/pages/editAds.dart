import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:little_paws/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:little_paws/pages/createProfile.dart';
import 'package:little_paws/pages/detailsPage.dart';

import '../showToast.dart';

class EditAd extends StatefulWidget {
  const EditAd({Key? key}) : super(key: key);

  @override
  State<EditAd> createState() => _EditAdState();
}



class _EditAdState extends State<EditAd> {
  
  @override
  Widget build(BuildContext context) {
    
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
                    Switch(value: false, onChanged: (value){},),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                 
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
                    onChanged: (value) {
                      setState(() {
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
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    context1 = context;
                    
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
