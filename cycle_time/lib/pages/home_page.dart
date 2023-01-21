import 'dart:convert';
import 'dart:io';

import 'package:cycle_time/pages/stop_watch.dart';
import 'package:cycle_time/utils/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as report;
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hive/hive.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../models/cycle_time.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List cycleList = [];
  final date = DateTime.now().obs;
  late final firstDate;
  TextEditingController dateController = TextEditingController();
  late Box myBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.red,
          title: const Text(
            'Dump Truck',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: const Icon(Icons.file_upload_outlined, size: 30),
                onPressed: cycleList.isEmpty ? null : uploadData,
              ),
            )
          ],
        ),
        // create floating action button
        // user can stat trip clicking thid button

        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColor.red,
          elevation: 10.0,
          onPressed: startTrip,
          label: Row(children: const [
            Icon(Icons.fire_truck),
            SizedBox(
              width: 20.0,
            ),
            Text(
              'Start Trip',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ]),
        ),

        // Home screen main body
        // we devided two seprate part upper body and lower body
        body: groupedList(),
      ),
    );
  }

  //open bottom drawer
  //Upload or Create excel sheet in selected date
  void upload() {}

  // Go to Cycle time Start page
  void startTrip() {
    Get.to(() => StopWatch());
  }

  Future<void> getData() async {
    myBox = await Hive.openBox('cycle_time');
    cycleList = myBox.values.toList();

    if (cycleList.isNotEmpty) {
      firstDate = cycleList.first.startTime;
    }

    setState(() {});
  }

  String timeFormat(duration) => duration.inHours == 0
      ? duration.inMinutes == 0
          ? "${(duration.inSeconds.remainder(60))} sec"
          : "${duration.inMinutes.remainder(60)} min ${(duration.inSeconds.remainder(60))} sec"
      : duration.inMinutes == 0
          ? "${(duration.inSeconds.remainder(60))} sec"
          : "${duration.inHours} Hour ${duration.inMinutes.remainder(60)} min ${(duration.inSeconds.remainder(60))} sec";

  Widget groupedList() {
    return cycleList.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cyclone,
                  size: 70.0,
                  color: Colors.grey.shade500,
                ),
                Text(
                  'Start Trip',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          )
        : GroupedListView<dynamic, String>(
            elements: cycleList,
            groupBy: (element) {
              return DateFormat('yy MMM dd').format(element.startTime);
            },
            groupComparator: (value1, value2) => value2.compareTo(value1),
            itemComparator: (item1, item2) =>
                item1.startTime.compareTo(item2.startTime),
            order: GroupedListOrder.ASC,
            useStickyGroupSeparators: true,
            groupSeparatorBuilder: (String value) {
              return Card(
                color: Colors.blue.shade200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  child: Text(
                    value.substring(3),
                    textAlign: TextAlign.start,
                  ),
                ),
              );
            },
            indexedItemBuilder: (c, cycle, index) {
              return Card(
                elevation: 3.0,
                child: SizedBox(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5.0),
                    title: Text('Cycle ${cycle.index}'),
                    subtitle: Text(timeFormat(cycle.cycle)),
                    leading: const Icon(
                      Icons.cyclone,
                      size: 50.0,
                    ),
                  ),
                ),
              );
            },
          );
  }

  void uploadData() {
    date.value = DateTime.now();

    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(20.0),
      title: "Upload Excel Sheet ",
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(color: Colors.black),
      middleTextStyle: const TextStyle(color: Colors.black),
      textConfirm: "Upload",
      textCancel: "Cancel",
      cancelTextColor: Colors.black,
      confirmTextColor: Colors.black,
      buttonColor: Colors.white,
      barrierDismissible: true,
      radius: 20,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Date'),
          const SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: selectDate,
            child: Row(
              children: [
                const Icon(
                  Icons.date_range,
                  size: 30.0,
                  color: Colors.blue,
                ),
                const SizedBox(
                  width: 10,
                ),
                Obx(() => Text(
                      DateFormat('yyyy/MM/dd').format(date.value),
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
      onConfirm: () => createExcelsheet(),
    );
  }

  Future<void> createExcelsheet() async {
    final report.Workbook workbook = report.Workbook();
    report.Worksheet sheet = workbook.worksheets[0];

    var filterCycleList = myBox.values
        .where((cycle) =>
            DateFormat('yyyy/MM/dd').format(cycle.startTime) ==
            DateFormat('yyyy/MM/dd').format(date.value))
        .toList();

    sheet.setColumnWidthInPixels(1, 100);
    sheet.setColumnWidthInPixels(2, 150);
    sheet.setColumnWidthInPixels(3, 150);
    sheet.setColumnWidthInPixels(4, 100);
    sheet.setColumnWidthInPixels(5, 100);
    sheet.setColumnWidthInPixels(6, 100);
    sheet.setColumnWidthInPixels(7, 100);
    sheet.setColumnWidthInPixels(8, 100);
    sheet.setColumnWidthInPixels(9, 100);

    sheet.getRangeByName('A1').setText('Date');
    sheet.getRangeByName('B1').setText('Start Time');
    sheet.getRangeByName('C1').setText('End Time');
    sheet.getRangeByName('D1').setText('Cycle Time');
    sheet.getRangeByName('E1').setText('Waiting for truck');
    sheet.getRangeByName('F1').setText(TruckActivties.loading.name);
    sheet.getRangeByName('G1').setText(TruckActivties.uphill.name);
    sheet.getRangeByName('H1').setText(TruckActivties.dumping.name);
    sheet.getRangeByName('I1').setText(TruckActivties.downhill.name);

    int rowIndex = 2;
    for (CycleTime cycle in filterCycleList) {
      sheet.getRangeByIndex(rowIndex, 1).setDateTime(cycle.startTime);
      sheet
          .getRangeByIndex(rowIndex, 2)
          .setText(DateFormat('HH:mm').format(cycle.startTime));
      sheet
          .getRangeByIndex(rowIndex, 3)
          .setText(DateFormat('HH:mm').format(cycle.endTime));
      sheet.getRangeByIndex(rowIndex, 4).setText(formatDuration(cycle.cycle));
      sheet.getRangeByIndex(rowIndex, 5).setText(formatDuration(cycle.start));
      sheet.getRangeByIndex(rowIndex, 6).setText(formatDuration(cycle.loading));
      sheet.getRangeByIndex(rowIndex, 7).setText(formatDuration(cycle.uphill));
      sheet.getRangeByIndex(rowIndex, 8).setText(formatDuration(cycle.dumping));
      sheet
          .getRangeByIndex(rowIndex, 9)
          .setText(formatDuration(cycle.downhill));
      rowIndex++;
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if (kIsWeb) {
      AnchorElement(
          href:
              'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'cycle.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
          Platform.isWindows ? '$path\\cycle.xlsx' : '$path/cycle.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }

  void selectDate() async {
    DateTime? selectedDate = await showDatePicker(
        initialDate: DateTime.now(),
        firstDate: firstDate,
        lastDate: DateTime.now(),
        context: context);

    if (selectedDate != null) {
      date.value = selectedDate;
    }
  }

  String formatDuration(Duration duration) {
    String twodigits(int n) => n.toString().padLeft(2, '0');
    var min = twodigits(duration.inMinutes.remainder(60));
    var sec = twodigits(duration.inSeconds.remainder(60));

    return '$min:$sec';
  }
}
