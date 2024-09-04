// ignore_for_file: prefer_const_constructors
import 'package:emaill/pages/registerorLoginPage.dart';
import 'package:emaill/pages/sec_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Checking the snapshot state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading state
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // User is logged in
            return SecPage(
              messageController: TextEditingController(),
              userNameController: TextEditingController(),
            );
          } else {
            // User is not logged in
            return RegisterorLoginpage();
          }
        },
      ),
    );
  }
}
