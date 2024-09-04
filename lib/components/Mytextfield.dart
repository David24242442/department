// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  //CONTROLLER
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obsureText;

  const Mytextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.obsureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obsureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 209, 193, 193),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 145, 89, 89)),
            ),
            fillColor: Color.fromARGB(255, 248, 245, 245),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[300])),
      ),
    );
  }
}
