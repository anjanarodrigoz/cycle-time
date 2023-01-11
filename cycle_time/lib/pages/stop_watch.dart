import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StopWatch extends StatelessWidget {
  const StopWatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          //Date and time display
          Row(
            children: const [
              Text(
                '2022/12/15',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                '12.20 pm',
                style: TextStyle(fontSize: 15.0),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
