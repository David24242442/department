// ignore_for_file: prefer_const_constructors

import 'package:emaill/components/glasseffect.dart';
import 'package:emaill/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'datatables.dart'; // Import Datatables
import 'aboutpage.dart';

class SecPage extends StatefulWidget {
  final TextEditingController userNameController;
  final TextEditingController messageController;

  SecPage({
    Key? key,
    required this.userNameController,
    required this.messageController,
  }) : super(key: key);

  @override
  State<SecPage> createState() => _SecPageState();
}

class _SecPageState extends State<SecPage> {
  String? selectedDepartment;
  final List<String> departments = [
    'HR',
    'IT',
    'Finance',
    'Marketing',
    'Sales',
    'Stores',
    'Head Office',
    'Account Office'
  ];
  String userMessage = "";
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomePage(onTap: () {})),
    );
  }

  void _navigateToDataTables(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Datatables(
          name: widget.userNameController.text, // Pass the name
          department: selectedDepartment ?? 'Unknown', // Pass the department
          message: widget.messageController.text, // Pass the message
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
        backgroundColor: const Color(0xFF778d6f),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFF778d6f),
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                'L O G O',
                style: TextStyle(fontSize: 30),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'ABOUT',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Aboutpage()));
              },
            )
          ],
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 234, 250, 234),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: widget.userNameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  prefixIcon: Icon(Icons.edit, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Department',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                value: selectedDepartment,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDepartment = newValue;
                  });
                },
                items:
                    departments.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            // Inside the _SecPageState build method

            Expanded(
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: userMessage.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Glasseffect(
                            width: double.infinity,
                            height: 100, // Adjust height as needed
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(
                                  10.0), // Add padding for better spacing
                              child: Text(
                                userMessage,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 51, 51,
                                      51), // Text color on frosted glass
                                ),
                                textAlign: TextAlign
                                    .left, // Ensure text alignment is left
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: TextField(
                  controller: widget.messageController,
                  textInputAction: TextInputAction.send,
                  maxLines: 2,
                  autofocus: true,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Make your Complaints",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          userMessage = widget.messageController.text;
                        });
                        _navigateToDataTables(
                            context); // Navigate to DataTables
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
