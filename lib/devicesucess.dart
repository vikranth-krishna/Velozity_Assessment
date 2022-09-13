import 'package:velozity_assesment/onboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_elves/flutter_blue_elves.dart';

class devicesucess extends StatefulWidget {
  Device device;
  devicesucess({Key? key, required this.device}) : super(key: key);

  @override
  State<devicesucess> createState() => _devicesucessState();
}

class _devicesucessState extends State<devicesucess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 153.84,
            ),
            Center(
              child: Container(
                height: 126.32,
                width: 126.32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                    image: AssetImage('assets/images/sucessimg.png'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Device paired sucessfully!',
              style: TextStyle(
                  color: Colors.grey[900],
                  fontFamily: 'Inter',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  height: 1.25),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Your device are ready to use',
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.25),
            ),
            SizedBox(height: 48),
            Align(
              alignment: Alignment.topLeft,
              child: Text('        Name your device',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.25)),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 68,
              width: 357,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Device Name',
                  hintStyle: TextStyle(
                      fontSize: 16, color: Colors.black, fontFamily: 'Inter'),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.indigo[50]!, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.indigo[50]!, width: 1.5),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  isDense: true,
                  contentPadding:
                      EdgeInsets.only(left: 20, top: 26, bottom: 26),
                ),
                style: TextStyle(
                  color: Colors.blueGrey[400],
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.text,
                enableInteractiveSelection: true,
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Container(
              height: 66,
              width: 372,
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Onboarding(device: widget.device),
                      ));
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  'Proceed',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
