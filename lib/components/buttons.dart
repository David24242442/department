// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  //ontap
  final Function()? onTap;

  const Buttons({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.black87, borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Text(
            "Sign In",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(193, 245, 224, 224)),
          ),
        ),
      ),
    );
  }
}
