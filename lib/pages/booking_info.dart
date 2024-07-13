import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookingInfoScreen extends StatefulWidget {
  @override
  _BookingInfoScreenState createState() => _BookingInfoScreenState();
}

class _BookingInfoScreenState extends State<BookingInfoScreen> {
  List<Map<String, dynamic>> bookings = [];

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget initializes
    fetchDataFromMongoDB();
  }

  Future<void> fetchDataFromMongoDB() async {
    // Replace with your backend API endpoint that fetches data from MongoDB
    var url = Uri.parse('https://your-backend-api-endpoint.com/bookings');
    
    try {
      var response = await http.get(url);
      
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        List<dynamic> data = jsonDecode(response.body);
        
        setState(() {
          bookings = data.map((item) => {
            'bookingTime': item['bookingTime'],
            'serviceType': item['serviceType'],
            'customerName': item['customerName'],
            'status': item['status'],
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
          'Your Booking Detail',
          style: TextStyle(color: Color(0xFF4713A3)),
        ),
        iconTheme: IconThemeData(color: Color(0xFF4713A3)),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int index = 0; index < bookings.length; index++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Card(
                      elevation: 3.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Booking Time: ${bookings[index]['bookingTime']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: Color(0xFF4713A3),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Status: ${bookings[index]['status']}',
                                  style: TextStyle(
                                    color: bookings[index]['status'] == 'Confirmed'
                                        ? Colors.green
                                        : Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              'Service Type: ${bookings[index]['serviceType']}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Customer: ${bookings[index]['customerName']}',
                              style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
