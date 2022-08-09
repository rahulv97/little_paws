import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:little_paws/colors.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:little_paws/showToast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../services/locationdata.dart';

bool booll = true;

class ShopRegister extends StatefulWidget {
  const ShopRegister({Key? key}) : super(key: key);

  @override
  State<ShopRegister> createState() => _ShopRegisterState();
}

File? imgFile;

String img_down_url = "";

var context1;

String first_name = "",
    last_name = "",
    country = "",
    phone = "",
    address = "",
    city = "",
    state = "",
    shop_name = "";

Image hello() {
  Image image = Image.asset(
    "assets/prof_pic.jpg",
    height: 125,
    width: 125,
    fit: BoxFit.cover,
  );
  if (imgFile == null) {
    image = Image.asset(
      "assets/prof_pic.jpg",
      height: 125,
      width: 125,
      fit: BoxFit.cover,
    );
  } else {
    image = Image.file(
      imgFile!,
      height: 125,
      width: 125,
      fit: BoxFit.cover,
    );
  }
  return image;
}

void checkPerm() async {
  var status = await Permission.storage.status;
  if (status.isDenied) {
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage].request();
  }

// You can can also directly ask the permission about its status.
  if (await Permission.location.isRestricted) {
    // The OS restricts access, for example because of parental controls.
  }
}

class _ShopRegisterState extends State<ShopRegister> {
  String dropdownvalue = 'Gender';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPerm();
  }

  // List of items in our dropdown menu
  var items = [
    'Gender',
    'Male',
    'Female',
    'Other',
  ];

  String? countryValue;
  String? stateValue;
  String? cityValue;

  @override
  Widget build(BuildContext context) {
    Future<void> add_data(value) async {
      DatabaseReference firebaseDatabase = FirebaseDatabase.instance
          .ref("users/" + FirebaseAuth.instance.currentUser!.uid);
      await firebaseDatabase.set({
        "profilePic": value,
        "first_name": first_name,
        "last_name": last_name,
        "country": country,
        "phone": phone,
        "address": address,
        "city": city,
        "state": state,
        "shop_name": shop_name,
        "user_type": "ShopOwner"
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
            .ref('profilePics/' +
                FirebaseAuth.instance.currentUser!.uid +
                '/profile_pic.png')
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

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/bg.png",
            fit: BoxFit.cover,
          ),
          ListView(children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 60),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Complete Your Profile",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: dark_selector),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: GestureDetector(
                      onTap: () {
                        _getFromGallery();
                      },
                      child: hello()),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Container(
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        shop_name = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Shop Name",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        labelText: "Shop Name",
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Container(
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        first_name = value;
                      },
                      decoration: InputDecoration(
                        hintText: "First Name",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        labelText: "First Name",
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Container(
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        last_name = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Last Name",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        labelText: "Last Name",
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                    height: 50,
                    child: InternationalPhoneNumberInput(
                      initialValue: PhoneNumber(isoCode: 'IN'),
                      onInputChanged: (PhoneNumber value) {
                        country = value.isoCode.toString();
                        phone = value.phoneNumber.toString();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Container(
                    child: TextField(
                      onChanged: (value) {
                        address = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Address",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        labelText: "Address",
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
                  padding: const EdgeInsets.all(20),
                  child: SelectState(
                    onCountryChanged: (value) {
                      setState(() {
                        countryValue = value;
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        stateValue = value;
                        state = value;
                      });
                    },
                    onCityChanged: (value) {
                      setState(() {
                        cityValue = value;
                        city = value;
                      });
                    },
                  ),
                ),

                // Row(
                //   children: [
                //     Padding(
                //       padding:
                //           const EdgeInsets.only(left: 20, right: 10, top: 30),
                //       child: Container(
                //         height: 50,
                //         width: MediaQuery.of(context).size.width / 2.4,
                //         child: TextField(
                //           onChanged: (value) {
                //             city = value;
                //           },
                //           decoration: InputDecoration(
                //             hintText: "City",
                //             border: const OutlineInputBorder(
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(12))),
                //             labelText: "City",
                //             enabledBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(12),
                //               borderSide: const BorderSide(
                //                 color: Color.fromARGB(255, 231, 231, 231),
                //                 width: 0.5,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     Padding(
                //       padding:
                //           const EdgeInsets.only(left: 10, right: 20, top: 30),
                //       child: Container(
                //         height: 50,
                //         width: MediaQuery.of(context).size.width / 2.4,
                //         child: TextField(
                //           onChanged: (value) {
                //             state = value;
                //           },
                //           decoration: InputDecoration(
                //             hintText: "State",
                //             border: const OutlineInputBorder(
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(12))),
                //             labelText: "State",
                //             enabledBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(12),
                //               borderSide: const BorderSide(
                //                 color: Color.fromARGB(255, 231, 231, 231),
                //                 width: 0.5,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 30),
                    child: GestureDetector(
                      onTap: () {
                        context1 = context;
                        if (imgFile == null) {
                          ShowToast().showToast("Please Select a profile pic");
                        } else if (shop_name.isEmpty) {
                          ShowToast().showToast("Shop Name is Required");
                        } else if (first_name.isEmpty) {
                          ShowToast().showToast("Name is Required");
                        } else if (last_name.isEmpty) {
                          ShowToast().showToast("Name is Required");
                        } else if (phone.isEmpty) {
                          ShowToast().showToast("Phone Number is Required");
                        } else if (address.isEmpty) {
                          ShowToast().showToast("Address is Required");
                        } else if (city.isEmpty) {
                          ShowToast().showToast("City is Required");
                        } else if (state.isEmpty) {
                          ShowToast().showToast("State is Required");
                        } else {
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
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'Bold'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
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

  /// Get from gallery
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
      imgFile = croppedImage;
      setState(() {});
    }
  }
}
