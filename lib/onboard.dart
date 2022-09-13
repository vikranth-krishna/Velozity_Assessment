import 'package:velozity_assesment/formfill.dart';
import 'package:velozity_assesment/handgrip.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_blue_elves/flutter_blue_elves.dart';

class Onboarding extends StatefulWidget {
  Device device;
  Onboarding({Key? key, required this.device}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = CarouselController();
  int activeIndex = 0;
  final image = [
    Image.asset('assets/images/feetwingsonboard1.jpg'),
    Image.asset('assets/images/feetwingsonboard1.jpg'),
    Image.asset('assets/images/feetwingsonboard1.jpg')
  ];

  void next() => controller.nextPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
            carouselController: controller,
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: false,
              // autoPlayAnimationDuration: const Duration(milliseconds: 800),
              height: 450,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index),
            ),
            items: [
              Container(
                // margin: EdgeInsets.all(6.0),
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: AssetImage('assets/images/feetwingsonboard1.jpg'),
                      fit: BoxFit.fill),
                ),
              ),
              Container(
                // margin: EdgeInsets.all(6.0),
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: AssetImage('assets/images/feetwingsonboard1.jpg'),
                      fit: BoxFit.fill),
                ),
              ),
              Container(
                // margin: EdgeInsets.all(6.0),
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: AssetImage('assets/images/feetwingsonboard1.jpg'),
                      fit: BoxFit.fill),
                ),
              ),
            ]),
        SizedBox(height: 10),
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: 3,
          effect: SlideEffect(
              activeDotColor: Colors.blue, dotColor: Colors.black12),
        ),
        SizedBox(height: 50),
        MaterialButton(
            height: 60,
            color: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: activeIndex < 2
                ? Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )
                : Text(
                    'Turn on Notification',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
            onPressed: () {
              if (activeIndex < 2) {
                next();
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => formfill(device: widget.device),
                    ));
              }
            }), // ElevatedButton
      ],
    ));
  }
}
