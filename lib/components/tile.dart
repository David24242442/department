// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final String imagePath;
  const Tile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(221, 255, 255, 255),
            border: Border.all(
              color: Colors.white,
            )),
        child: Image.asset(
          imagePath,
          height: 48,
        ));
  }
}
