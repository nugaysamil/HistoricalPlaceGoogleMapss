import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mapsuygulama/components/my_button.dart';
import 'package:mapsuygulama/components/tr_eng_button.dart';
import 'package:mapsuygulama/login/register.dart';

import '../components/my_textfield.dart';
import '../pages/forgot_password.dart';
import '../pages/google.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  // ignore: prefer_final_fields
  int _success = 1;

  late bool loginFail = false;

  // ignore: unused_field
  late String _userEmail = "";

  void _signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ))
          .user;

      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomMarkerInfoWindow(),
          ),
        );
      }
    } catch (e) {
      loginFail = true;
      Navigator.pop(context);

      if (loginFail == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("Hatali giriş"),
              content: new Text("Tekrar Deneyiniz"),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Icon(
                Icons.lock,
                size: 100,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Hello'.tr,
                style: GoogleFonts.bebasNeue(fontSize: 52),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'welcome'.tr,
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                controller: _emailController,
                hintText: "E-mail",
                obscureText: false,
              ),
              SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: _passwordController,
                hintText: "sifre_girin".tr,
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ForgotPasswordPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'forget'.tr,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MyButton(
                text2: 'Giris'.tr,
                onTap: _signIn,
              ),
              SizedBox(
                height: 15,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'member'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      'register_now'.tr,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Get.to(() => SignupPage(),
                          transition: Transition.rightToLeft,
                          duration: Duration(seconds: 1));
                    },
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TrEnButton()
            ],
          ),
        ),
      ),
    );
  }
}
