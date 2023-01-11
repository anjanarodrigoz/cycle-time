import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_theme.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 50.0),
                  Image.asset(
                    'assets/insee.png',
                    height: 90.0,
                    width: 300.0,
                  ),
                  const Text(
                    'Cycle Time Calculator',
                    style: TextStyle(
                        color: AppColor.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0),
                  ),
                  const SizedBox(height: 50.0),
                  const Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    //User id text field
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Id',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //Password text field
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        fixedSize: const Size(200, 50), // specify width, height
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                          20,
                        ))),
                    onPressed: () {
                      Get.to(() => const HomePage());
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {}
}
