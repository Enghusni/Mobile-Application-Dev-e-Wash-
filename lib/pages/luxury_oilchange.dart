import 'dart:async';
import 'package:flutter/material.dart';
import 'luxury_oilchange_booking.dart';

class LuxuryOilChangeScreen extends StatefulWidget {
  @override
  _LuxuryOilChangeScreenState createState() => _LuxuryOilChangeScreenState();
}

class _LuxuryOilChangeScreenState extends State<LuxuryOilChangeScreen> {
  final List<String> images = [
    'images/070 White Pearl Crystal Shine_1.png',
    'images/images.jpg',
    'images/Land-Cruiser-AC-service-min.jpg',
    'images/FXMwSRLXgAESCu8.jpg',
    // Add more image paths as needed
  ];

  late PageController _pageController;
  late Timer _timer;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);

    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_currentPageIndex < images.length - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      _pageController.animateToPage(
        _currentPageIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Luxury Cars',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF4713A3),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF4713A3) , size: 30,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Oil Change',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4713A3),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'The benefits of changing your oil on time are numerous. Regular oil changes enhance engine performance, longevity, and peak gas mileage by keeping engine controls clean and lubricated.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LuxuryOilChangeBookingScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4713A3),
                      minimumSize: Size(double.infinity, 60),
                    ),
                    child: Text(
                      'Book Now',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
