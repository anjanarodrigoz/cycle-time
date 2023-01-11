import 'package:cycle_time/utils/app_theme.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
}
