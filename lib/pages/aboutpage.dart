// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Aboutpage extends StatelessWidget {
  const Aboutpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF778d6f),
        title: Text('About Page'),
      ),
      // ignore: prefer_const_constructors.
      body: _buildPage(),
    );
  }

  Widget _buildPage() {
    return SingleChildScrollView(
      child: SizedBox(
        width: 360,
        height: 800,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 350,
                  height: 800,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 234, 250, 234),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: const Center(
                    child: Text('Centered Content'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 350,
                height: 300,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(180),
                      bottomLeft: Radius.circular(180)),
                  color: Color(0xFF778d6f),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
