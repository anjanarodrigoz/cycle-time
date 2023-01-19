import 'package:cycle_time/utils/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    init();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/insee.png'),
          const Text(
            'Cycle Time Calculator',
            style: TextStyle(
                color: AppColor.red,
                fontWeight: FontWeight.w600,
                fontSize: 30.0),
          ),
          const SizedBox(
            height: 300.0,
          ),
          const Text(
            'Developed by Shark Developers',
            style: TextStyle(fontSize: 10.0),
          )
        ],
      ),
    );
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.off(() => const HomePage());
  }
}
