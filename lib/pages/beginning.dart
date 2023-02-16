import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/tr_eng_button.dart';
import '../login/login.dart';
import 'package:lottie/lottie.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              animation(),
              SizedBox(
                height: 35,
              ),
              Text(
                'Welcome2'.tr,
                style: GoogleFonts.bebasNeue(fontSize: 52),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Information'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(
                    color: Colors.grey[700],
                    fontSize: 15,
                  ),
                ),
              ),
              TrEnButton(),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Start'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Get.to(
                    () => MyHomePage(),
                    transition: Transition.rightToLeft,
                    duration: Duration(seconds: 1),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget animation() {
  return Container(
    width: 400,
    height: 300,
    child: Lottie.network(
        'https://assets6.lottiefiles.com/packages/lf20_EcWipt2nmD.json'),
  );
}
