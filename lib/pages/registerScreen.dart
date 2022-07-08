import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:little_paws/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:little_paws/showToast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

makeToast(message) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

class _RegisterScreenState extends State<RegisterScreen> {
  var firebaseAuth = FirebaseAuth.instance;
  String email = "", password = "", confPassword = "";
  bool term = false;
  Future register(email, password) async {
    final reg = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  bool cbValue = false;

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

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
          ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/register_cat.png",
                    height: 125,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Welcome, Create your account",
                    style: TextStyle(
                        color: Colors.black, fontSize: 22, fontFamily: 'Bold'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Register",
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
                        "Create an Account to start Using",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 15),
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 15),
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      height: 50,
                      child: TextField(
                        onChanged: (value) {
                          confPassword = value;
                        },
                        obscureText: _obscured,
                        decoration: InputDecoration(
                          hintText: "*********",
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          labelText: "Confirm Password",
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
                  CheckboxListTile(
                    checkColor: theme_color,
                    activeColor: Colors.white,
                    side: BorderSide(color: Colors.grey, width: 1),
                    title: const Text(
                      "By Signing up I Agree to the",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    subtitle: GestureDetector(
                      onTap: (() => {makeToast("Terms")}),
                      child: Text(
                        "Terms and Condition & Privacy Policy",
                        style: TextStyle(fontSize: 12, color: dark_selector),
                      ),
                    ),
                    value: cbValue,
                    onChanged: (newValue) {
                      setState(() {
                        cbValue = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 12,
                              color: dark_selector,
                              fontFamily: 'Bold'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        if (!cbValue) {
                          ShowToast().showToast(
                              "Please Accept Terms and Conditions first");
                        } else if (email.isEmpty) {
                          ShowToast().showToast("Email is required");
                        } else if (password.isEmpty) {
                          ShowToast().showToast("Password is required");
                        } else if (confPassword.isEmpty) {
                          ShowToast()
                              .showToast("Confirmed Password is required");
                        } else if (password != confPassword) {
                          ShowToast().showToast(
                              "Password and Confirm Password should be same");
                        } else {
                          register(email, password)
                              .onError((error, stackTrace) =>
                                  ShowToast().showToast(error.toString()))
                              .then((value) {
                            if (firebaseAuth.currentUser != null) {
                              ShowToast()
                                  .showToast("Registeration Successfull");
                              Navigator.pushNamed(context, "user_category");
                            }
                          });
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
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'Bold'),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
