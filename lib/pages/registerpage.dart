// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:emaill/components/Mytextfield.dart';
import 'package:emaill/components/buttons.dart';
import 'package:emaill/components/tile.dart';
import 'package:emaill/pages/datatables.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatelessWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Passwords do not match."),
      ));
      return;
    }
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      Navigator.of(context).pop(); // Close the loading dialog
      Navigator.pushNamed(context, '/pages/sec'); // Navigate to the second page
    } on FirebaseAuthException catch (e) {
      String message;

      if (e.code == 'email-already-in-use') {
        message = 'The email address is already in use.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else {
        message = 'Failed to sign up: ${e.message}';
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
      final email = emailController.text;
      Navigator.of(context).pop();
      // Close the loading dialog
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Datatables(
              name: '',
              department: '',
              message: '',
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
              child: Text("SIGN UP PAGE",
                  style: TextStyle(
                    color: Color.fromARGB(255, 194, 194, 194),
                    fontSize: 16,
                  ))),
          backgroundColor: Color.fromARGB(255, 26, 27, 27)),
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 67, 112, 88),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 5),
                  const Icon(Icons.lock, size: 80),
                  const SizedBox(height: 30),
                  const Text(
                    "Welcome to the Sign Up Page",
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
                  Mytextfield(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obsureText: true,
                  ),
                  SizedBox(height: 15),
                  Buttons(
                    onTap: () => signUserUp(context),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(
                            'sign up with',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: const Color.fromARGB(255, 129, 73, 73),
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
                  SizedBox(height: 90),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 243, 242, 242),
                          )),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: onTap,
                        child: Text(
                          'Log in now',
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
