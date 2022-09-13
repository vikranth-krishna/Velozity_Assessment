import 'package:flutter/material.dart';

class deviceunsucess extends StatefulWidget {
  const deviceunsucess({Key? key}) : super(key: key);

  @override
  State<deviceunsucess> createState() => _deviceunsucessState();
}

class _deviceunsucessState extends State<deviceunsucess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/deviceunsucess.png'))),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                minWidth: 372,
                height: 66,
                onPressed: () {
                  Navigator.pushNamed(context, '/searchdevice');
                },
                color: Colors.grey[20],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  'Search again',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.blue,
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
