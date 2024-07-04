import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF4713A3),
        title: Text('About Us' , style: TextStyle(color: Colors.white,),
        ),
        iconTheme: IconThemeData(color: Colors.white, size:30,),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height:15),
              Text(
                'Welcome to eWash App!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4713A3),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'At our carwash, we offer a range of services to keep your vehicle looking its best. Our team of skilled professionals is dedicated to providing top-notch care for your vehicle, ensuring it stays clean, shiny, and protected. From thorough washes to specialized treatments, we have everything you need to maintain the beauty and value of your car. Discover the difference with our premium services :',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 20.0),
              _buildServiceTile(
                icon: Icons.local_car_wash,
                title: 'Polishing',
                description: 'Restore the shine to your vehicle with our professional polishing services.',
                
              ),
              _buildServiceTile(
                icon: Icons.bubble_chart,
                title: 'Foaming',
                description: 'Experience a deep clean with our foaming service, removing dirt and grime from every surface.',
              ),
              _buildServiceTile(
                icon: Icons.build,
                title: 'Oil Change',
                description: 'Keep your engine running smoothly with our oil change services, performed by trained technicians.',
              ),
              SizedBox(height: 20.0),
              Text(
                'Contact Us:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4713A3),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Address: KM4 TaleexStreet, Mogadishu, Somalia',
                style: TextStyle(fontSize: 14.0),
              ),
              Text(
                'Phone: +252 613114335',
                style: TextStyle(fontSize: 14.0),
              ),
              Text(
                'Email: ewashcenter@gmail.com',
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceTile({required IconData icon, required String title, required String description}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(icon, size: 32.0, color: Color(0xFF4713A3),),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4713A3),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  description,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AboutUsScreen(),
  ));
}
