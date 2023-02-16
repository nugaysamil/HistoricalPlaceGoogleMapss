import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:mapsuygulama/login/login.dart';
import 'package:mapsuygulama/pages/beginning.dart';
import 'package:mapsuygulama/pages/google.dart';
import 'languages/languages.dart';
import 'login/register.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: override_on_non_overriding_member
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(),
      locale: Get.locale == null ? Get.deviceLocale : Get.locale,
      fallbackLocale: Languages.defaultt,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomMarkerInfoWindow(),
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => const SignupPage(),
      },
    );
  }
}
