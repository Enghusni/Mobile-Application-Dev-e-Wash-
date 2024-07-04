import 'dart:async';
import 'package:flutter/material.dart';
import 'luxury_polish_booking.dart';

class PolishingScreen extends StatefulWidget {
  @override
  _PolishingScreenState createState() => _PolishingScreenState();
}

class _PolishingScreenState extends State<PolishingScreen> {
  final List<String> images = [
    'images/toyota-land-cruiser-prado-car.png',
    'images/download.jpg',
    'images/mqdefault.jpg',
    'images/v8.PNG',
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
        iconTheme: IconThemeData(color: Color(0xFF4713A3), size: 30),
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
                  height: MediaQuery.of(context).size.width * 0.8, // Adjusted height
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
                    'Polishing',
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
                      'The benefits of polishing your car are many and varied depending on what your car needs. Such as reducing scratches, reviving paintwork, restoring fading, removing road contamination, paint correction and your annual paint protection maintenance.',
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
                        MaterialPageRoute(builder: (context) => LuxuryPolishBookingScreen()),
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
