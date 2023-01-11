import 'package:cycle_time/utils/app_theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List cycleList = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // create floating action button
        // user can stat trip clicking thid button

        floatingActionButton: FloatingActionButton.extended(
          elevation: 10.0,
          onPressed: startTrip,
          label: Row(children: const [
            Text(
              'Start Trip',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ]),
        ),

        // Home screen main body
        // we devided two seprate part upper body and lower body
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              children: [upperBody(), const SizedBox(height: 20), lowerBody()]),
        ),
      ),
    );
  }

  upperBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              '2022/12/15',
              style: TextStyle(fontSize: 20.0),
            ),
            const Text(
              '12.20 pm',
              style: TextStyle(fontSize: 20.0),
            ),
            IconButton(
                onPressed: upload,
                icon: const Icon(
                  Icons.upload_rounded,
                  size: 40.0,
                  color: AppColor.greenTwo,
                ))
          ],
        ),
        const Text(
          'Dump Truck 01',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Mr.Ajith',
          style: TextStyle(fontSize: 18.0),
        ),
      ],
    );
  }

  // Lower widgets
  // display today cycle times
  lowerBody() {
    return Expanded(
      child: ListView.builder(
        itemCount: cycleList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                title: Text('Cycle ${index + 1}'),
                subtitle: const Text('40 min 30 sec'),
              ),
              const Divider(
                height: 2.0,
              )
            ],
          );
        },
      ),
    );
  }

  //open bottom drawer
  //Upload or Create excel sheet in selected date
  void upload() {}

  // Go to Cycle time Start page
  void startTrip() {}
}
