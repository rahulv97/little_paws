// ignore_for_file: sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:little_paws/colors.dart';
import 'package:little_paws/showToast.dart';

bool booll = true;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  var firebaseAuth = FirebaseAuth.instance;
  String email = "", password = "";

  Future signIn(String email, String password) async {
    final _user = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  void showToast(message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/login_cat.png",
                  height: 125,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Login to your account",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Bold',
                    fontSize: 22,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Login",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: dark_selector,
                          fontFamily: 'Bold'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 8),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Login With Your Account To Continue",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Container(
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        labelText: "Email",
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: _obscured,
                      decoration: InputDecoration(
                        hintText: "*********",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        labelText: "Password",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 231, 231, 231),
                            width: 0.5,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                          child: GestureDetector(
                            onTap: _toggleObscured,
                            child: Icon(
                              _obscured
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "forgetPass");
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 20, top: 15),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20, top: 30),
                    child: Text(
                      "Login with Gmail or Facebook",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          signInwithGoogle();
                        },
                        child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            width: (MediaQuery.of(context).size.width / 3) + 20,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(200)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/gmail.png",
                                  height: 20,
                                  width: 20,
                                ),
                                Text(
                                  "  Gmail",
                                  style: TextStyle(
                                      color: dark_selector,
                                      fontFamily: 'Bold',
                                      fontSize: 12),
                                ),
                              ],
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          height: 50,
                          alignment: Alignment.center,
                          width: (MediaQuery.of(context).size.width / 3) + 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(200)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/facebook.png",
                                height: 20,
                                width: 20,
                              ),
                              Text(
                                "  Facebook",
                                style: TextStyle(
                                    color: dark_selector,
                                    fontFamily: 'Bold',
                                    fontSize: 12),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't Have An Account yet?",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "register");
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 12,
                            color: dark_selector,
                            fontFamily: 'Bold'),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      if (email.isEmpty) {
                        showToast("Please enter a valid email!");
                      } else if (password.isEmpty) {
                        showToast("Please enter a valid password!");
                      } else {
                        try {
                          setState(() {
                            booll = false;
                          });
                          signIn(email, password).onError((error, stackTrace) {
                            setState(() {
                              booll = true;
                            });
                            //Navigator.of(context, rootNavigator: true).pop();
                            showToast(error.toString());
                          }).then((value) {
                            DatabaseReference databaseReference =
                                FirebaseDatabase.instance.ref("users");
                            setState(() {
                              booll = true;
                            });
                            //Navigator.of(context, rootNavigator: true).pop();
                            databaseReference.onValue.listen((event) {
                              if (event.snapshot
                                  .child(FirebaseAuth.instance.currentUser!.uid)
                                  .exists) {
                                Navigator.pushReplacementNamed(
                                    context, "dashboard");
                              } else {
                                Navigator.pushReplacementNamed(
                                    context, "user_category");
                              }
                            });
                          });
                        } catch (e) {
                          setState(() {
                            booll = true;
                          });
                          //Navigator.of(context, rootNavigator: true).pop();
                          showToast(e.toString());
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
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Bold'),
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential).then((value) {
        showToast(firebaseAuth.currentUser.toString());
        DatabaseReference databaseReference =
            FirebaseDatabase.instance.ref("users");

        databaseReference.onValue.listen((event) {
          if (event.snapshot
              .child(FirebaseAuth.instance.currentUser!.uid)
              .exists) {
            Navigator.pushReplacementNamed(context, "dashboard");
          } else {
            Navigator.pushReplacementNamed(context, "user_category");
          }
        });
      }).onError((error, stackTrace) {
        ShowToast().showToast(error.toString());
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }
}
