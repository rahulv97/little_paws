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

class IndEditProfile extends StatefulWidget {
  const IndEditProfile({Key? key}) : super(key: key);

  @override
  State<IndEditProfile> createState() => _IndEditProfileState();
}

File? imgFile;

String img_down_url = "";

Future<void> uploadFile(String filePath) async {
  File file = File(filePath);

  try {
    var snap = await firebase_storage.FirebaseStorage.instance
        .ref('profilePics/' +
            FirebaseAuth.instance.currentUser!.uid +
            '/profile_pic.png')
        .putFile(file);

    await snap.ref.getDownloadURL().then((value) => add_data(value));
  } catch (e) {
    // e.g, e.code == 'canceled'
  }
}

var context1;

String first_name = first_name_person.text,
    last_name = last_name_person.text,
    country = "",
    phone = "",
    address = address_cont.text,
    city = city_person.text,
    state = state_cont.text;

Future<void> add_data(value) async {
  DatabaseReference firebaseDatabase = FirebaseDatabase.instance
      .ref("users/" + FirebaseAuth.instance.currentUser!.uid);

  if (imgFile == null) {
    await firebaseDatabase
        .update({
          "shop_name": shop_name_cont.text,
          "first_name": first_name,
          "last_name": last_name,
          "country": country,
          "phone": phone,
          "address": address,
          "city": city,
          "state": state,
          "user_type": "Individual"
        })
        .onError((error, stackTrace) => ShowToast().showToast(error.toString()))
        .then((value) => Navigator.pushReplacementNamed(context1, "dashboard"));
  } else {
    await firebaseDatabase
        .update({
          "shop_name": shop_name_cont.text,
          "profilePic": value,
          "first_name": first_name,
          "last_name": last_name,
          "country": country,
          "phone": phone,
          "address": address,
          "city": city,
          "state": state,
          "user_type": "Individual"
        })
        .onError((error, stackTrace) => ShowToast().showToast(error.toString()))
        .then((value) => Navigator.pushReplacementNamed(context1, "dashboard"));
  }
}

Image hello() {
  Image image = Image.asset(
    "assets/prof_pic.jpg",
    height: 125,
    width: 125,
    fit: BoxFit.cover,
  );

  if (imgFile == null) {
    image = Image.network(
      profile_img_url,
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

String profile_img_url = "";
TextEditingController first_name_person = TextEditingController();
TextEditingController last_name_person = TextEditingController();
TextEditingController address_cont = TextEditingController();
TextEditingController city_person = TextEditingController();
TextEditingController state_cont = TextEditingController();
TextEditingController shop_name_cont = TextEditingController();

var country_person = "";
var mobile_number = "";

bool prof_type = false;

class _IndEditProfileState extends State<IndEditProfile> {
  String dropdownvalue = 'Gender';

  var type = "";

  @override
  void initState() {
    Future getProfile() async {
      DatabaseReference databaseReference = FirebaseDatabase.instance
          .ref("users/" + FirebaseAuth.instance.currentUser!.uid);
      await databaseReference.onValue.listen((event) {
        setState(() {
          profile_img_url = event.snapshot.child("profilePic").value.toString();
          first_name_person.text =
              event.snapshot.child("first_name").value.toString();
          last_name_person.text =
              event.snapshot.child("last_name").value.toString();
          city_person.text = event.snapshot.child("city").value.toString();
          country_person = event.snapshot.child("country").value.toString();
          state_cont.text = event.snapshot.child("state").value.toString();
          mobile_number = event.snapshot.child("phone").value.toString();
          address_cont.text = event.snapshot.child("address").value.toString();
          shop_name_cont.text =
              event.snapshot.child("shop_name").value.toString();
          //ShowToast().showToast(mobile_number);
        });
      });
      // ShowToast().showToast(profile_img_url);
    }

    getProfile();
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

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    setState(() {
      type = arguments["type"];
      if (type == "ShopOwner") {
        prof_type = true;
      } else {
        prof_type = false;
      }
    });

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
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Update Your Profile",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: dark_selector),
                        ),
                      ),
                    ],
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
                prof_type
                    ? Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        child: Container(
                          height: 50,
                          child: TextField(
                            controller: shop_name_cont,
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
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Container(
                    height: 50,
                    child: TextField(
                      controller: first_name_person,
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
                      controller: last_name_person,
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
                      initialValue: PhoneNumber(
                          isoCode: "IN", phoneNumber: mobile_number),
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
                      controller: address_cont,
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
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 10, top: 30),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: TextField(
                          controller: city_person,
                          onChanged: (value) {
                            city = value;
                          },
                          decoration: InputDecoration(
                            hintText: "City",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            labelText: "City",
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
                      padding:
                          const EdgeInsets.only(left: 10, right: 20, top: 30),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: TextField(
                          controller: state_cont,
                          onChanged: (value) {
                            state = value;
                          },
                          decoration: InputDecoration(
                            hintText: "State",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            labelText: "State",
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
                  ],
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 30),
                    child: GestureDetector(
                      onTap: () {
                        context1 = context;
                        if (imgFile == null) {
                          if (first_name.isEmpty) {
                            ShowToast().showToast("Name is Required");
                          } else if (prof_type && shop_name_cont.text == "") {
                            ShowToast().showToast("Shop Name is Required");
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
                            add_data("");
                          }
                        } else {
                          if (first_name.isEmpty) {
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
                            uploadFile(imgFile!.path);
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
                          "Update Profile",
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
          ])
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
