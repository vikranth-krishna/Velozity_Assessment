
import 'dart:async';

import 'package:velozity_assesment/devicesucess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hex/hex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_blue_elves/flutter_blue_elves.dart';

class searchdevice extends StatefulWidget {
  const searchdevice({Key? key}) : super(key: key);

  @override
  State<searchdevice> createState() => _searchdeviceState();
}

class _searchdeviceState extends State<searchdevice> {
  var blepermission =Permission.bluetooth;
  var locpermission = Permission.location;
  var perL = AndroidBluetoothLack.locationPermission;
  var perB = AndroidBluetoothLack.bluetoothPermission;
  late DeviceState _deviceState;
  late int _mtu;
  late StreamSubscription<BleService> _serviceDiscoveryStream;
  late StreamSubscription<DeviceState> _stateStream;
  late StreamSubscription<DeviceSignalResult> _deviceSignalResultStream;
  final List<_ConnectedItem> _connectedList = [];
  late final List<_ServiceListItem> _serviceInfos;

  @override
  void initState() {
    FlutterBlueElves.instance.startScan(5000).listen((event) {
      if(event.name == "AssistAid"){
        print("connected");
        setState(() {
          Device toConnectDevice = event.connect(connectTimeout: 10000);
          setState(() {
            _connectedList.insert(0, _ConnectedItem(toConnectDevice));
          });
          _ConnectedItem currentConnected = _connectedList[0];
          _mtu = currentConnected._device.mtu;

          _stateStream = currentConnected._device.stateStream.listen((event) {
            if (event == DeviceState.connected) {
              setState(() {
                _mtu = currentConnected._device.mtu;

              });
              currentConnected._device.discoveryService();
            }
            setState(() {
              _deviceState = event;
            });
          });
          // _deviceSignalResultStream = currentConnected._device.deviceSignalResultStream.listen((event) {
          //   // print("Result");
          //   String data = '';
          //
          //   var op2 = event;
          //
          //   if (op2.data != null && op2.data!.isNotEmpty) {
          //     data = '';
          //     for (int i = 0; i < op2.data!.length; i++) {
          //       String currentStr = op2.data![i].toRadixString(16);
          //       if (currentStr.length < 2) {
          //         currentStr = "0" + currentStr;
          //       }
          //       data = data + currentStr;
          //     }
          //     data = String.fromCharCodes(HEX.decode(data));
          //
          //   }
          // });
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => devicesucess(device: toConnectDevice),
              ));





        });


      }

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Searching for Device',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.grey[900],
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.w400,
              height: 1.25),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () => Navigator.pop(context),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 8,
          ),
          Text(
            ' Please keep your device close',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey[700],
                height: 1.50),
          ),
          Text(
            '   to pair and connect ',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey[700],
                height: 1.50),
          ),
          SizedBox(
            height: 150,
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(),
              child: SpinKitDoubleBounce(
                size: 140,
                // color: Colors.black,
                itemBuilder: (context, index) {
                  // final colors = [Colors.yellow, Colors.white];
                  // final color = colors[index % colors.length];

                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                        image: AssetImage('assets/images/dynometer.jpg'),
                      ),
                    ),
                  );
                },
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/devicesucess');
            },
            onDoubleTap: () {
              Navigator.pushNamed(context, '/deviceunsucess');
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceListItem {
  final BleService _serviceInfo;
  bool _isExpanded;

  _ServiceListItem(this._serviceInfo, this._isExpanded);
}

class _ConnectedItem {
  final Device _device;

  _ConnectedItem(this._device);
}
