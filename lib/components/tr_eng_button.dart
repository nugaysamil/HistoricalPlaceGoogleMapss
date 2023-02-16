import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrEnButton extends StatefulWidget {
  const TrEnButton({super.key});

  @override
  State<TrEnButton> createState() => _TrEnButtonState();
}

class _TrEnButtonState extends State<TrEnButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(25),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'EN'.tr,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          onTap: () {
            Get.updateLocale(
              Locale("en", "US"),
            );
          },
        ),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(25),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'TR'.tr,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          onTap: () {
            Get.updateLocale(
              Locale("tr", "TR"),
            );
          },
        ),
      ],
    );
  }
}
