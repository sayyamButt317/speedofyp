import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../Controller/getxcontroller.dart';
import 'recharge.dart';

class PaymentCard extends StatefulWidget {
  const PaymentCard({Key? key}) : super(key: key);

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  final Controller getxcontroller = Get.put<Controller>(Controller());

  final String _scanBarcodeResult = '';
  Future<void> scanner() async {
    String scanQr;
    try {
      scanQr = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      debugPrint(scanQr);
      if (scanQr == '-1') {
        return;
      }

      if (scanQr.contains("deduct20")) {
        // QR code scan successful, and it contains "deduct20", deduct 20 Rs.
        setState(() {
          getxcontroller.value -= 20;
        });
        Get.defaultDialog(
          title: 'Payment Successful',
          titlePadding: const EdgeInsets.only(top: 20),
          content: Column(
            children: [
              Image.asset("images/Accept.png", height: 100, width: 100),
              const SizedBox(height: 20),
              const Text('20 Rs deducted successfully.'),
            ],
          ),
          contentPadding: const EdgeInsets.all(20),
          confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("OK"),
          ),
        );
      } else {
        // QR code scan successful but doesn't contain "deduct20".
        // Show an error dialog.
        Get.defaultDialog(
          title: 'Invalid QR Code',
          titlePadding: const EdgeInsets.only(top: 20),
          content: Column(
            children: [
              Image.asset("images/reject.png",
                  height: 100, width: 100), // Adjust size as needed
              const SizedBox(height: 20),
              const Text('This QR code is not eligible for deduction.'),
            ],
          ),
          contentPadding: const EdgeInsets.all(20),
          confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("OK"),
          ),
        );
      }
    } on PlatformException {
      scanQr = 'Failed to get platform version';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          title: Text(
            'Register',
            style: GoogleFonts.lato(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 20),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 15.0, bottom: 10.0),
                child: Text("Pay your ride fare in just Single Scan!",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage("images/card.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.black,
                            Color.fromARGB(255, 121, 136, 145)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Obx(() {
                            return Text(
                              "Balance: ${getxcontroller.value} Rs",
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const Recharge();
                            },
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.black,
                              Color.fromARGB(255, 121, 136, 145)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Recharge",
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              MaterialButton(
                onPressed: () async {
                  scanner();
                },
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.black),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: const AssetImage(
                        "images/qrcode.png",
                      ),
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    const Spacer(),
                    const Text("PAY ",
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
