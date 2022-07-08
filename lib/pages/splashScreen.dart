import 'package:flutter/material.dart';
import 'package:little_paws/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/splash.png",
            fit: BoxFit.cover,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 85),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, "onboard1"),
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
                    "Get Started",
                    style: TextStyle(
                        color: Colors.white, fontSize: 17, fontFamily: 'Bold'),
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
