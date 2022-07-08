import 'package:flutter/material.dart';
import 'package:little_paws/colors.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/onboard2.png", fit: BoxFit.cover,),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, "onboard3"),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: theme_color,
                      borderRadius: const BorderRadius.all(const Radius.circular(200)),
                      boxShadow: [
                        BoxShadow(
                            color: theme_color,
                            blurRadius: 12,
                            offset: const Offset(5, 5))
                      ]),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
