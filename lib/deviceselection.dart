import 'package:flutter/material.dart';

class deviceselect extends StatefulWidget {
  const deviceselect({Key? key}) : super(key: key);

  @override
  State<deviceselect> createState() => _deviceselectState();
}

class _deviceselectState extends State<deviceselect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Select your Device',
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
        children: [
          Text(
            '       Please keep your device close ',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey[700],
                height: 1.50),
          ),
          Text(
            '         to pair and connect ',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey[700],
                height: 1.50),
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20, width: 20),
              GestureDetector(
                child: Container(
                  height: 219.73,
                  width: 172,
                  // color: Colors.grey[50],
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 37.82, left: 43.22, bottom: 37.82, right: 43.22),
                    child: Container(
                      height: 120.67,
                      width: 86.45,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/dynometer.jpg'),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Test Device',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blueGrey[700],
                                  height: 1.50),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: Colors.blue[400]!, width: 1.50)),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/searchdevice');
                },
              ),
              SizedBox(height: 20, width: 20),
              Container(
                height: 219.73,
                width: 172,
                color: Colors.grey[50],
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 37.82, left: 43.22, bottom: 37.82, right: 43.22),
                  child: Container(
                    height: 120.67,
                    width: 86.45,
                    decoration: const BoxDecoration(
                      // color: Colors.yellow[100],
                      image: DecorationImage(
                        image: AssetImage('assets/images/dynometer.jpg'),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Smart Patch',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey[700],
                                height: 1.50),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(height: 20, width: 20),
              Container(
                height: 219.73,
                width: 172,
                color: Colors.grey[50],
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 37.82, left: 43.22, bottom: 37.82, right: 43.22),
                  child: Container(
                    height: 120.67,
                    width: 86.45,
                    decoration: const BoxDecoration(
                      // color: Colors.yellow[100],
                      image: DecorationImage(
                        image: AssetImage('assets/images/dynometer.jpg'),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Lorem Ipsum',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey[700],
                                height: 1.50),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
