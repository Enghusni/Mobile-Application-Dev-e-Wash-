import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking Details',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: BookingInfoScreen(),
    );
  }
}

class BookingInfoScreen extends StatefulWidget {
  @override
  _BookingInfoScreenState createState() => _BookingInfoScreenState();
}

class _BookingInfoScreenState extends State<BookingInfoScreen> {
  List<Map<String, dynamic>> bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDataFromMongoDB();
  }

  Future<void> fetchDataFromMongoDB() async {
    var url = Uri.parse('http://192.168.43.170:5000/api/bookings');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> docs = jsonResponse['data']['docs'];

        setState(() {
          bookings = docs.map((item) {
            DateTime dateTime = DateTime.parse(item['dateTime']);
            String formattedTime = DateFormat('dd/MM/yyyy hh:mm:ss a').format(dateTime);

            return {
              'bookingTime': formattedTime,
              'serviceType': item['serviceType'] ?? 'Unknown Service',
              'customerName': item['customerName'] ?? 'Unknown Customer',
              'status': item['status'] ?? 'Unknown Status',
            };
          }).toList();
          isLoading = false;
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Details',
          style: TextStyle(color: Color(0xFF4713A3)),
        ),
        iconTheme: IconThemeData(color: Color(0xFF4713A3)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int index = 0; index < bookings.length; index++)
                      Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.event,
                                    size: 25.0,
                                    color: Color(0xFF4713A3),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    ' ${bookings[index]['bookingTime']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.local_car_wash,
                                    size: 25.0,
                                    color: Color(0xFF4713A3),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    ' ${bookings[index]['serviceType']}',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 25.0,
                                    color: Color(0xFF4713A3),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    ' ${bookings[index]['customerName']}',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'Status: ${bookings[index]['status']}',
                                  style: TextStyle(
                                    color: bookings[index]['status'] == 'approved' ? Colors.green : Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
