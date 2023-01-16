import 'package:hive_flutter/adapters.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  final typeId = 100;

  Duration read(BinaryReader reader) {
    return Duration(seconds: reader.read());
  }

  void write(BinaryWriter writer, Duration obj) {
    writer.write(obj.inSeconds);
  }
}
