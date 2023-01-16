import 'package:cycle_time/controllers/stopwatch_contoller.dart';
import 'package:cycle_time/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../models/cycle_time.dart';
import 'home_page.dart';

enum TruckActivties { start, loading, uphill, dumping, downhill, stop }

class StopWatch extends StatefulWidget {
  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  final StopWatchController controller = Get.put(StopWatchController());
  final text = TruckActivties.start.obs;
  final activity = 'Press Start'.obs;
  final btnColor = AppColor.green.obs;
  late DateTime startTime, endTime;
  Map<String, Duration> durations = {};
  Duration currentDuration = const Duration();
  bool back = false;
  late final myBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.delete<StopWatchController>();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onwillpop,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                  activity.value,
                  style: const TextStyle(
                      fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              buildTime(),
              const SizedBox(
                height: 50.0,
              ),
              controllButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTime() {
    return Obx(
      () => Text(
        '${controller.hours.value}:${controller.minutes.value}:${controller.seconds.value}',
        style: TextStyle(
            fontSize: 90.0, color: btnColor.value, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget controllButton() {
    return Obx(
      () => ElevatedButton(
        onPressed: goNext,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor.value,
          fixedSize: const Size(350, 150),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
            20,
          )),
        ),
        child: Text(
          text.value.name.toUpperCase(),
          style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void goNext() {
    switch (text.value) {
      case TruckActivties.start:
        text.value = TruckActivties.loading;
        activity.value = 'Waiting for excavator...';
        btnColor.value = AppColor.yellow;
        controller.startTimer();
        startTime = DateTime.now();
        break;

      case TruckActivties.loading:
        durations[TruckActivties.start.name] =
            controller.duration.value - currentDuration;
        currentDuration = controller.duration.value;
        text.value = TruckActivties.uphill;
        activity.value = 'Loading...';
        btnColor.value = AppColor.blue;
        break;

      case TruckActivties.uphill:
        durations[TruckActivties.loading.name] =
            controller.duration.value - currentDuration;
        currentDuration = controller.duration.value;
        text.value = TruckActivties.dumping;
        activity.value = 'Up hilling...';
        btnColor.value = AppColor.purple;
        break;

      case TruckActivties.dumping:
        durations[TruckActivties.uphill.name] =
            controller.duration.value - currentDuration;
        currentDuration = controller.duration.value;
        text.value = TruckActivties.downhill;
        activity.value = 'Dumping...';
        btnColor.value = AppColor.pink;
        break;

      case TruckActivties.downhill:
        durations[TruckActivties.dumping.name] =
            controller.duration.value - currentDuration;
        currentDuration = controller.duration.value;
        text.value = TruckActivties.stop;
        activity.value = 'Down hilling...';
        btnColor.value = AppColor.red;
        break;

      case TruckActivties.stop:
        endTime = DateTime.now();
        controller.stopTimer();
        durations[TruckActivties.downhill.name] =
            controller.duration.value - currentDuration;
        currentDuration = controller.duration.value;
        completeCycleTime();

        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<StopWatchController>();
  }

  Future<bool> _onwillpop() async {
    return back;
  }

  Future<void> completeCycleTime() async {
    int index = getIndex();
    await myBox.add(CycleTime(
        start:
            durations[TruckActivties.start.name] ?? const Duration(seconds: 0),
        loading: durations[TruckActivties.loading.name] ??
            const Duration(seconds: 0),
        uphill:
            durations[TruckActivties.uphill.name] ?? const Duration(seconds: 0),
        dumping: durations[TruckActivties.dumping.name] ??
            const Duration(seconds: 0),
        downhill: durations[TruckActivties.downhill.name] ??
            const Duration(seconds: 0),
        cycle: currentDuration,
        startTime: startTime,
        endTime: endTime,
        index: index));

    Get.offAll(const HomePage());
  }

  Future<void> getData() async {
    myBox = await Hive.openBox('cycle_time');
  }

  int getIndex() {
    if (myBox.values.isNotEmpty) {
      CycleTime cycle = myBox.values.last;
      int index = cycle.index;
      if (DateFormat('yy MMM dd').format(cycle.startTime) ==
          DateFormat('yy MMM dd').format(startTime)) {
        return index + 1;
      } else {
        return 1;
      }
    } else {
      return 1;
    }
  }
}
