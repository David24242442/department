// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, use_super_parameters

import 'package:emaill/pages/datatables.dart';
import 'package:emaill/pages/sec_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emaill/components/Mytextfield.dart';
import 'package:emaill/components/buttons.dart';
import 'package:emaill/components/tile.dart';

class HomePage extends StatefulWidget {
  final Function()? onTap;

  const HomePage({Key? key, required this.onTap}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn(BuildContext context) async {
    // Show loading circle
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      // Close the loading dialog
      Navigator.of(context).pop();

      if (emailController.text == 'test1@gmail.com') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Datatables(
                      name: '',
                      department: '',
                      message: '',
                    )));
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecPage(
              messageController: TextEditingController(),
              userNameController: emailController,
            ),
          ),
        );
      } // Close the loading dialog
      // Navigator.pushNamed(context, '/pages/sec');
    } on FirebaseAuthException catch (e) {
      String message;

      if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else {
        message = 'Failed to sign in: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));

      Navigator.of(context).pop(); // Close the loading dialog
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An unexpected error occurred."),
        ),
      );

      Navigator.of(context).pop(); // Close the loading dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "LOGIN PAGE",
            style: TextStyle(
              color: Color.fromARGB(255, 194, 194, 194),
              fontSize: 16,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 26, 27, 27),
      ),
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 67, 112, 88),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  const Icon(Icons.lock, size: 80),
                  const SizedBox(height: 30),
                  const Text(
                    "Welcome to the Login Page",
                    style: TextStyle(
                        color: Color.fromARGB(255, 243, 242, 242),
                        fontSize: 16),
                  ),
                  SizedBox(height: 30),
                  Mytextfield(
                    controller: emailController,
                    hintText: 'Email',
                    obsureText: false,
                  ),
                  SizedBox(height: 10),
                  Mytextfield(
                    controller: passwordController,
                    hintText: "Password",
                    obsureText: true,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 243, 242, 242)),
                  ),
                  SizedBox(height: 15),
                  Buttons(
                    onTap: () => signUserIn(context),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color.fromARGB(255, 51, 66, 47),
                            thickness: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(
                            "or Continue With",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color.fromARGB(255, 42, 48, 41),
                            thickness: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Tile(
                        imagePath: 'lib/images/4.png',
                      )
                    ],
                  ),
                  SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not a member?',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 243, 242, 242),
                          )),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: widget.onTap, // Ensure this is set correctly
                        child: Text(
                          'Register now',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
