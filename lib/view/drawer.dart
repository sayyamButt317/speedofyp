import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:speedo/view/payment.dart';
import 'package:speedo/view/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../repository/googleauth.dart';
import 'package:speedo/Model/usermodel.dart';
import 'dart:async';
import 'package:get/get.dart';

class Appdrawer extends StatefulWidget {
  const Appdrawer({super.key});

  @override
  State<Appdrawer> createState() => _AppdrawerState();
}

class _AppdrawerState extends State<Appdrawer> {
  var myuser = UserModel().obs;

  final Uri _url = Uri.parse("https://pma.punjab.gov.pk/");
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.only(top: 8.0),
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                children: [
                  Icon(Icons.phone, color: Colors.white),
                  SizedBox(width: 10),
                  Text.rich(
                    TextSpan(
                      text: "(042) 111-222-627 ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "Support",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profile()),
                    );
                  },
                  child: const Text("Profile")),
              leading: const Icon(
                Icons.person,
                color: Colors.black,
                size: 30,
              ),
            ),
            ListTile(
              title: GestureDetector(
                  onTap: () {
                    _launchUrl();
                  },
                  child: const Text("Punjab MassTransit")),
              leading: const Icon(
                LineIcons.history,
                color: Colors.black,
                size: 30,
              ),
            ),
            ListTile(
              title: GestureDetector(
                  onTap: () => Get.to(() => const PaymentCard()),
                  child: const Text("Fare Pay")),
              leading: const Icon(
                LineIcons.creditCard,
                color: Colors.black,
                size: 30,
              ),
            ),
            ListTile(
                title: GestureDetector(
                    onTap: () => AuthService().signOut(),
                    child: const Text("Sign out")),
                leading: const Icon(
                  Icons.lock,
                  color: Colors.black,
                  size: 30,
                )),
          ],
        ),
      ),
    );
  }
}
