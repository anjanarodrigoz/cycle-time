import 'dart:async';

import 'package:get/get.dart';

class StopWatchController extends GetxController {
  Duration _duration = const Duration();
  Timer? _timer;
  final duration = const Duration(seconds: 0).obs;
  bool stop = false;
  final hours = '00'.obs;
  final minutes = '00'.obs;
  final seconds = '00'.obs;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      addTime();
    });
  }

  void addTime() {
    const addSecond = 1;

    var sec = _duration.inSeconds;
    if (!stop) {
      sec = _duration.inSeconds + addSecond;
    }
    _duration = Duration(seconds: sec);

    String twodigits(int n) => n.toString().padLeft(2, '0');
    hours.value = twodigits(_duration.inHours.remainder(60));
    minutes.value = twodigits(_duration.inMinutes.remainder(60));
    seconds.value = twodigits(_duration.inSeconds.remainder(60));
    duration.value = _duration;
  }

  void stopTimer() {
    stop = true;
  }

  void reStartTimer() {
    stop = false;
  }
}
