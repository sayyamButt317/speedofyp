import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speedo/view/login.dart';
import '../Controller/getxcontroller.dart';
import '../utils/constant.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmpass = TextEditingController();

  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var passwordVisible;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  final Controller getxcontroller = Get.put<Controller>(Controller());
  final List<String> _images = [
    'https://ouch-cdn2.icons8.com/tSgdQCON_ry4WkBETVT2kz7ft-FOWw_27mVFNzILxuk/rs:fit:256:192/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvOTA1/L2JhMTA3MjE5LTli/YzktNGQ4Yy04NzZi/LTM5MmFkY2VjOGY0/Yy5zdmc.png',
    'https://ouch-cdn2.icons8.com/d0nj1Z_jOO5ZZmFKJPYFNFlPkCO9ORVGxr9rrDN_kMg/rs:fit:256:162/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNjk0/LzQyYTEwMjgyLTQx/NjctNDdjZS04MTkx/LWY1ZWI0M2Y4MTMw/Mi5zdmc.png',
    "https://ouch-cdn2.icons8.com/rn7UiCFEGMbuxJ8MxZSSRgw-QAbUyaeoaQDll5FyYDk/rs:fit:512:384/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvMzk3/L2RjNDIyMjQ2LTJk/NDQtNDU0YS05Mjdm/LTU4MGQ3MjA0OTY3/ZS5wbmc.png",
  ];

  startTimer() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      getxcontroller.activeIndex.value++;
      if (getxcontroller.activeIndex.value == 3) {
        getxcontroller.activeIndex.value = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _email.dispose();
    _password.dispose();
    _confirmpass.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    passwordVisible = true;
  }

  void login() async {
    await _auth
        .createUserWithEmailAndPassword(
            email: _email.text.toString(), password: _password.text.toString())
        .then((value) {
      getxcontroller.isprofileloading(false);
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      getxcontroller.isprofileloading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text(
          'Register',
          style: GoogleFonts.lato(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 220,
                  child: Stack(
                    children: _images.asMap().entries.map((e) {
                      return Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: AnimatedOpacity(
                          duration: const Duration(seconds: 1),
                          opacity:
                              getxcontroller.activeIndex.value == e.key ? 1 : 0,
                          child: Image.network(
                            e.value,
                            height: 400,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Email!";
                          }
                          return null;
                        },
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Email",
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
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        validator: (String? password) {
                          if (password == null || password.isEmpty) {
                            return 'Please enter your password';
                          }

                          if (password.length < 6) {
                            return 'Your password is too short';
                          } else if (password.length < 8) {
                            return 'Your password is acceptable but not strong';
                          }
                          if (!letterReg.hasMatch(password) ||
                              !numReg.hasMatch(password)) {
                            return 'Add special Character and Captial and small Alphabet ';
                          } else {
                            return null;
                          }
                        },
                        controller: _password,
                        obscureText: passwordVisible,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Password",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
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
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value != _password.text) {
                            return 'Password Not Match';
                          } else {
                            return null;
                          }
                        },
                        controller: _confirmpass,
                        obscureText: passwordVisible,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          hintText: "Confirm Password",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
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
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 15,
                ),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        }
                      },
                      height: 50,
                      minWidth: 300,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 50,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.black,
                      child: Obx(() {
                        return getxcontroller.isprofileloading.value
                            ? const CircularProgressIndicator(
                                strokeWidth: 3,
                                color: Colors.white,
                              )
                            : const Text(
                                "Sign-up",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account?",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.to(
                        () => const Login(),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
