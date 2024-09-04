// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/authpage.dart';
import 'pages/registerPage.dart'; // Ensure you import your RegisterPage
import 'pages/sec_page.dart';
import 'pages/datatables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: const Authpage(), // Use AuthPage to manage authentication flow
      routes: {
        '/pages/sec': (context) => SecPage(
              messageController: TextEditingController(),
              userNameController: TextEditingController(),
            ),
        '/register': (context) => RegisterPage(
              onTap: () {
                // Handle navigation if needed
              },
            ),
        // Remove Datatables route here, since email needs to be passed dynamically
      },
    );
  }
}
