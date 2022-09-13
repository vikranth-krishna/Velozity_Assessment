import 'dart:async';
import 'dart:typed_data';

import 'package:velozity_assesment/neck.dart';
import 'package:velozity_assesment/patient.dart';
import 'package:velozity_assesment/patientservice.dart';
import 'package:velozity_assesment/user.dart';
import 'package:velozity_assesment/userservice.dart';
import 'package:flutter/material.dart';
import 'package:hex/hex.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:flutter_blue_elves/flutter_blue_elves.dart';

List<_OpKgs> data = [
  _OpKgs('Jan', 35, 50, 100),
  _OpKgs('Feb', 28, 60, 100),
  _OpKgs('Mar', 34, 80, 100),
  _OpKgs('Apr', 32, 70, 100),
  _OpKgs('May', 70, 95, 100),
  _OpKgs('Jun', 69, 80, 100)
];

int count = 19;
List<_ChartData> chartData = <_ChartData>[
  _ChartData(0, 42),
  _ChartData(1, 47),
  _ChartData(2, 33),
  _ChartData(3, 49),
  _ChartData(4, 54),
  _ChartData(5, 41),
  _ChartData(6, 58),
  _ChartData(7, 51),
  _ChartData(8, 98),
  _ChartData(9, 41),
  _ChartData(10, 53),
  _ChartData(11, 72),
  _ChartData(12, 86),
  _ChartData(13, 52),
  _ChartData(14, 94),
  _ChartData(15, 92),
  _ChartData(16, 86),
  _ChartData(17, 72),
  _ChartData(18, 94),
];
ChartSeriesController? _chartSeriesController;

class LS extends StatefulWidget {
  Device device;
  final int id;
  LS({Key? key, required this.device, required this.id}) : super(key: key);

  @override
  State<LS> createState() => _LSState();
}

class _LSState extends State<LS> with SingleTickerProviderStateMixin{
  double lsval = 0;
  late StreamSubscription<DeviceSignalResult> _deviceSignalResultStream;
  String data12 = '';
  String dataStr = "4C53";
  var _userService = UserService();
  late AnimationController controller;
  late Animation rangeAnimation;
  bool test = true;
  bool flag = true;

  var _patientService = PatientService();
  var id;
  int? c;
  String name = "";
  String p_id = "";
  String mail = "";
  String age = "";
  String gender = "";
  String mstats = "";
  String hand = "";
  String finger = "";
  String foot = "";
  String arm = "";
  String leg = "";
  String neck = "";
  String back = "";
  late List<patient> _patientList;

  getall() async{
    var users = await _patientService.readAllPatient();
    _patientList = <patient>[];
    users.forEach((user) {
      setState(() {
        var usermodel = patient();
        usermodel.id = user['id'];
        usermodel.patientid = user['patientid'];
        usermodel.patientname = user['patientname'];
        usermodel.patientemail = user['patientemail'];
        usermodel.patientage = user['patientage'];
        usermodel.patientgender = user['patientgender'];
        usermodel.patientmaritalstatus = user['patientmaritalstatus'];
        usermodel.hand = user['hand'];
        usermodel.finger = user['finger'];
        usermodel.foot = user['foot'];
        usermodel.arm = user['arm'];
        usermodel.leg = user['leg'];
        usermodel.neck = user['neck'];
        usermodel.back = user['back'];
        _patientList.add(usermodel);
      });
      id = widget.id;
      c = id - 1;

      Future.delayed(const Duration(milliseconds: 500), () async {
        setState(() {
          p_id = _patientList[c!].patientid!;
          name = _patientList[c!].patientname!;
          mail = _patientList[c!].patientemail!;
          age = _patientList[c!].patientage!;
          gender = _patientList[c!].patientgender!;
          mstats = _patientList[c!].patientmaritalstatus!;
          hand = _patientList[c!].hand!;
          finger = _patientList[c!].finger!;
          foot = _patientList[c!].foot!;
          arm = _patientList[c!].arm!;
          leg = _patientList[c!].leg!;
          neck = _patientList[c!].neck!;
          back = _patientList[c!].back!;
        });
      });
    });




  }

  animate() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    rangeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
    });
    controller.addListener(() {
      setState(() {});
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        test = false;
      });
    });
  }

  _write() async {
    Uint8List data = Uint8List(dataStr.length ~/ 2);
    for (int i = 0; i < dataStr.length ~/ 2; i++) {
      data[i] = int.parse(dataStr.substring(i * 2, i * 2 + 2),
          radix: 16);
    }
    widget.device.setNotify("6e400001-b5a3-f393-e0a9-e50e24dcca9e",
        "6e400003-b5a3-f393-e0a9-e50e24dcca9e", true);

    widget.device.writeData("6e400001-b5a3-f393-e0a9-e50e24dcca9e", "6e400002-b5a3-f393-e0a9-e50e24dcca9e", true, data);
    print("write done");
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    _deviceSignalResultStream.cancel();
    super.dispose();
  }

  @override
  void initState() {
    animate();
    getall();

    _deviceSignalResultStream =
        widget.device.deviceSignalResultStream.listen((event) {
          if (event.data != null && event.data!.isNotEmpty) {
            data12 = '';
            for (int i = 0; i < event.data!.length; i++) {
              String currentStr = event.data![i].toRadixString(16);
              if (currentStr.length < 2) {
                currentStr = "0" + currentStr;
              }
              data12 = data12 + currentStr;
            }

            data12 = String.fromCharCodes(HEX.decode(data12));
            print(data12);

            if(flag){
              if (data12.startsWith("LS")) {
                print("LS");
              } else {
                print(data12.length);
                print(data12[2]);
                String val = '';
                // val = data12.substring(1);
                // val = val + data12[3];
                val = val + data12[1];
                val = val + data12[2];
                // val = val + data12[4];
                print(val);
                print("done");
                setState(() {
                  lsval = double.parse(val);
                  val = '';
                });
              }
            }
          }
        });
    // write();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leg Strength'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SfRadialGauge(
                title: const GaugeTitle(
                    text: 'Leg Strength',
                    textStyle:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                axes: <RadialAxis>[
                  RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 0,
                        endValue: 50,
                        color: Colors.green,
                        startWidth: 10,
                        endWidth: 10),
                    GaugeRange(
                        startValue: 50,
                        endValue: 100,
                        color: Colors.orange,
                        startWidth: 10,
                        endWidth: 10),
                    GaugeRange(
                        startValue: 100,
                        endValue: 150,
                        color: Colors.red,
                        startWidth: 10,
                        endWidth: 10)
                  ],
                      ticksPosition: ElementsPosition.outside,
                      labelsPosition: ElementsPosition.outside,
                      interval: 10,
                      pointers: <GaugePointer>[
                    NeedlePointer(value: test
                        ? ((100 * rangeAnimation.value).toDouble())
                        : lsval)
                  ], annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Text('$lsval',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        angle: 90,
                        positionFactor: 0.5)
                  ])
                ]),
            ElevatedButton(
              onPressed: () async{
                String h = lsval.toString();
                var _p = patient();
                _p.id = id;
                _p.patientid = p_id;
                _p.patientname = name;
                _p.patientemail = mail;
                _p.patientage = age;
                _p.patientgender = gender;
                _p.patientmaritalstatus = mstats;
                _p.hand = hand;
                _p.finger = finger;
                _p.foot  = foot;
                _p.arm = arm;
                _p.leg = h;
                _p.neck = neck;
                _p.back = back;
                var result = await _patientService.UpdatePatient(_p);

                print(result);
                setState(() {
                  flag = false;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NS(device: widget.device, id: id,),
                    ));
              },
              child: const Text('Next'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  lsval = 0;
                });
              },
              child: const Text('Calibrate'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
              onPressed: _write,
              child: const Text('Start'),
            ),

            SfCartesianChart(
                margin: const EdgeInsets.all(20),
                enableAxisAnimation: true,
                plotAreaBorderWidth: 0,
                enableSideBySideSeriesPlacement: false,
                title: ChartTitle(text: 'Leg Strength Analysis'),
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                    majorTickLines: const MajorTickLines(size: 0),
                    numberFormat: NumberFormat.compact(),
                    majorGridLines: const MajorGridLines(width: 0),
                    rangePadding: ChartRangePadding.round),
                series: <ColumnSeries<_OpKgs, String>>[
                  ColumnSeries<_OpKgs, String>(
                      dataSource: data,
                      width: 0.2,
                      xValueMapper: (_OpKgs sales, _) => sales.year,
                      yValueMapper: (_OpKgs sales, _) => sales.totwt,
                      name: '2014',
                      borderRadius: BorderRadius.circular(15),
                      animationDuration: 7000,
                      color: Colors.grey[350]),
                  ColumnSeries<_OpKgs, String>(
                      dataSource: data,
                      width: 0.2,
                      xValueMapper: (_OpKgs sales, _) => sales.year,
                      yValueMapper: (_OpKgs sales, _) => sales.expwt,
                      name: '2010',
                      borderRadius: BorderRadius.circular(15),
                      animationDuration: 7000,
                      color: Colors.grey),
                  ColumnSeries<_OpKgs, String>(
                      dataSource: data,
                      width: 0.2,
                      xValueMapper: (_OpKgs sales, _) => sales.year,
                      yValueMapper: (_OpKgs sales, _) => sales.weight,
                      name: '2006',
                      borderRadius: BorderRadius.circular(15),
                      animationDuration: 7000,
                      color: Colors.black54)
                ]),
          ],
        ),
      ),
    );
  }
}

class _OpKgs {
  _OpKgs(this.year, this.weight, this.expwt, this.totwt);

  final String year;
  final double weight;
  final int expwt;
  final int totwt;
}

class _ChartData {
  _ChartData(this.country, this.sales);
  final int country;
  final num sales;
}

int _getRandomInt(int min, int max) {
  final math.Random random = math.Random();
  return min + random.nextInt(max - min);
}

void _updateDataSource(Timer timer) {
  bool isCardView = true;
  if (isCardView) {
    chartData.add(_ChartData(count, _getRandomInt(10, 100)));
    if (chartData.length == 20) {
      chartData.removeAt(0);
      _chartSeriesController!.updateDataSource(
        addedDataIndexes: <int>[chartData.length - 1],
        removedDataIndexes: <int>[0],
      );
    } else {
      _chartSeriesController!.updateDataSource(
        addedDataIndexes: <int>[chartData.length - 1],
      );
    }
    count = count + 1;
  }
}
