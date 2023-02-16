import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/my_textfield.dart';
import '../components/tr_eng_button.dart';
import 'login.dart';

import 'package:get/get.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  late bool _sucess;
  // ignore: unused_field
  late String _userEmail;

  void signUp() async {
    if (passwordConfirmed()) {
      final User? user = (await _auth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text))
          .user;

      if (user != null) {
        setState(() {
          _sucess = true;

          _userEmail = user.email!;
        });
      } else {
        setState(() {
          _sucess = false;
        });
      }
      if (_sucess == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("You have successfully registered"),
              //content: new Text("You can log in with your new subscription."),
            );
          },
        );
      }
    }
  }


  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
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
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Icon(
                Icons.android,
                size: 100,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Kayit'.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
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
              MyTextField(
                controller: _confirmpasswordController,
                hintText: "TekrarGir".tr,
                obscureText: true,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'register'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  signUp();
                  Get.to(
                    () => MyHomePage(),
                    transition: Transition.rightToLeft,
                    duration: Duration(seconds: 1),
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),

              /* Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  _success == 1
                      ? ''
                      : (_success == 2
                          ? 'Successfully signed in $_userEmail'
                          : (_success == 3)
                              ? '"No'
                              : '123'),
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ), */

              TrEnButton(),
            ],
          ),
        ),
      ),

      /* Container(
            height: 40,
            child: Material(
              borderRadius: BorderRadius.circular(20),
              shadowColor: Colors.greenAccent,
              color: Colors.black,
              elevation: 7,
              child: GestureDetector(
                onTap: () async {
                  _register();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  );
                },
                child: Center(
                    child: Text(
                  'register'.tr,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                )),
              ),
            ),
          ), */

      /*  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'geriye_don'.tr,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monserrat',
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ), */
    );
  }
}
