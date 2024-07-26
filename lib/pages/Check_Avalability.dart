import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Availability Checker',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: CheckAvailabilityScreen(),
    );
  }
}

class CheckAvailabilityScreen extends StatefulWidget {
  @override
  _CheckAvailabilityScreenState createState() => _CheckAvailabilityScreenState();
}

class _CheckAvailabilityScreenState extends State<CheckAvailabilityScreen> {
  List<Map<String, dynamic>> availableTimes = [];

  @override
  void initState() {
    super.initState();
    // Fetch availability data when the widget initializes
    fetchDataFromMongoDB();
  }

  Future<void> fetchDataFromMongoDB() async {
    var url = Uri.parse('http://192.168.43.170:5000/api/bookings');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        setState(() {
          availableTimes = data.map((item) => {
            'dateTime': item['dateTime'],
            'available': item['available'],
            'serviceType': item['serviceType'],
          }).toList();
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        // Handle other status codes as needed
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle network errors or exceptions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Check Availability',
          style: TextStyle(color: Color(0xFF4713A3)),
        ),
        iconTheme: IconThemeData(color: Color(0xFF4713A3)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: availableTimes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          availableTimes[index]['dateTime'],
                          style: TextStyle(fontSize: 16.0),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Service Type: ${availableTimes[index]['serviceType']}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(height: 4),
                            Text(
                              availableTimes[index]['available'] ? 'Status: Available' : 'Status: Not Available',
                              style: TextStyle(
                                color: availableTimes[index]['available'] ? Colors.green : Colors.red,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          availableTimes[index]['available'] ? Icons.check_circle_outline : Icons.cancel_outlined,
                          color: availableTimes[index]['available'] ? Colors.green : Colors.red,
                        ),
                        onTap: () {
                          if (availableTimes[index]['available']) {
                            // Handle booking or any action here
                            print('Booked ${availableTimes[index]['dateTime']} for ${availableTimes[index]['serviceType']}');
                          } else {
                            // Handle unavailable action
                            print('Unavailable ${availableTimes[index]['dateTime']} for ${availableTimes[index]['serviceType']}');
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
