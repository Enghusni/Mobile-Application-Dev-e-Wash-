import 'dart:async';
import 'package:flutter/material.dart';
import 'tracks_polish_booking.dart';

class TracksPolishingScreen extends StatefulWidget {
  @override
  _TracksPolishingScreenState createState() => _TracksPolishingScreenState();
}

class _TracksPolishingScreenState extends State<TracksPolishingScreen> {
  final List<String> images = [
    'images/service3.jpg',
    'images/acid-wheel-cleaners.jpg',
    'images/IMG_5053-300x300.jpg',
    'images/1585876767.jpg',
    // Add more image paths as needed
  ];

  late PageController _pageController;
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);

    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % images.length;
      });
      _pageController.animateToPage(
        _currentIndex,
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
          'Truck Cars',
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
                        _currentIndex = index;
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
                      'The benefits of polishing your truck are many and varied depending on what your truck needs. Such as reducing scratches, reviving paintwork, restoring fading, removing road contamination, paint correction and your annual paint protection maintenance.',
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
                        MaterialPageRoute(builder: (context) => TracksPolishBookingScreen()),
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
