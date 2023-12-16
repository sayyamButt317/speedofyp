import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:speedo/repository/googleauth.dart';
import '../Service/map.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void checkLogin() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Get.offAll(() => const MapPage());
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    child: const Image(
                      image: AssetImage("images/location-map.gif"),
                    )),
                const SizedBox(height: 20),
                Text(
                  "Track Your Ride",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade900),
                ),
                Text(
                  "Easy as You Think!",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w200,
                      color: Colors.grey.shade900),
                ),
                const SizedBox(height: 15),
                Container(
                  height: MediaQuery.of(context).size.height * 0.01,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                        onPressed: () async {
                          await AuthService().signInWithGoogle(context);
                        },
                        color: Colors.white70,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.blueGrey)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(
                                image: const AssetImage(
                                  "images/google-logo.png",
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              const Spacer(),
                              const Text("Login with Gmail ",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              const Spacer(),
                            ]))),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                      onPressed: () => Get.to(() => const Login()),
                      color: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey.shade300)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image(
                            image: const AssetImage(
                              "images/email.png",
                            ),
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          const Spacer(),
                          const Text(
                            "Login via Email",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          const Spacer(),
                        ],
                      )),
                ),
              ])),
        ),
      ),
    );
  }
}
