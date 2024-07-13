import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    // Replace with your backend API endpoint that fetches availability data from MongoDB
    var url = Uri.parse('https://your-backend-api-endpoint.com/availableTimes');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        List<dynamic> data = jsonDecode(response.body);

        setState(() {
          availableTimes = data.map((item) => {
            'dateTime': item['dateTime'],
            'available': item['available'],
            'serviceType': item['serviceType'],
            'duration': item['duration'],
          }).toList();
        });
      } else {
        // Handle other status codes as needed
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or exceptions
      print('Error fetching data: $e');
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
                              availableTimes[index]['available'] ? 'Available' : 'Not Available',
                              style: TextStyle(
                                color: availableTimes[index]['available'] ? Colors.green : Colors.red,
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Service Type: ${availableTimes[index]['serviceType']}, Duration: ${availableTimes[index]['duration']}',
                              style: TextStyle(fontSize: 12.0),
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
