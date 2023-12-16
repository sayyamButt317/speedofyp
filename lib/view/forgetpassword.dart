import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controller/getxcontroller.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  final Controller getxcontroller = Get.put<Controller>(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text(
          'Forget Password',
          style: GoogleFonts.lato(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(
              image: const AssetImage(
                "images/lock.png",
              ),
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Row(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  "Forget Password?",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const Text(
              "Don't worry! it happens.Please enter the Email we will send the recovery link on the email ",
              style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Email";
                        }
                        return null;
                      },
                      controller: emailcontroller,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter Your Email to Recover Password",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: const Icon(
                          Icons.alternate_email,
                          color: Colors.black,
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () {
                    auth
                        .sendPasswordResetEmail(
                            email: emailcontroller.text.toString())
                        .then((value) {
                      Get.snackbar(
                        'Success',
                        'We have sent you email to recover passwod, please check email',
                        backgroundColor: Colors.transparent,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(16),
                        colorText: Colors.green,
                        borderWidth: 1,
                        borderColor: Colors.green,
                      );
                    }).onError((error, stackTrace) {
                      Get.snackbar(
                        'Error',
                        error.toString(),
                        backgroundColor: Colors.transparent,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(16),
                        colorText: Colors.red,
                        borderWidth: 1,
                        borderColor: Colors.red,
                      );
                    });
                  },
                  height: 50,
                  minWidth: 400,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.black,
                  child: Obx(() {
                    return getxcontroller.isprofileloading.value
                        ? const CircularProgressIndicator(
                            strokeWidth: 3, color: Colors.white)
                        : const Text(
                            "Send us Email!",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          );
                  }),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
