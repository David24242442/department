// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:emaill/pages/homepage.dart';
import 'package:emaill/pages/registerPage.dart';

class RegisterorLoginpage extends StatefulWidget {
  const RegisterorLoginpage({super.key});

  @override
  State<RegisterorLoginpage> createState() => _RegisterorLoginpageState();
}

class _RegisterorLoginpageState extends State<RegisterorLoginpage> {
  bool showRegister = false; // Start with the login page

  void togglePages() {
    setState(() {
      showRegister = !showRegister;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showRegister) {
      return RegisterPage(onTap: togglePages);
    } else {
      return HomePage(onTap: togglePages);
    }
  }
}
