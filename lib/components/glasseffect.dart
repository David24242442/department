// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'dart:ui'; // For using ImageFilter.blur

class Glasseffect extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const Glasseffect({
    Key? key,
    required this.child,
    this.width = double.infinity,
    this.height = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 169, 206, 184)
            .withOpacity(0.2), // Slightly opaque background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color.fromARGB(255, 211, 210, 210).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur effect
          child: Container(
            alignment: Alignment.center,
            color: Colors.white.withOpacity(0.2), // Another layer of opacity
            child: child, // Your message or content goes here
          ),
        ),
      ),
    );
  }
}
