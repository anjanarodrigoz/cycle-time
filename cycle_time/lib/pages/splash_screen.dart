import 'package:cycle_time/pages/home_page.dart';
import 'package:cycle_time/utils/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        ],
      ),
    );
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.off(() => const HomePage());
  }
}
