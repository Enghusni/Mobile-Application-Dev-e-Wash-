import 'package:flutter/material.dart';

class BookingInfoScreen extends StatefulWidget {
  @override
  _BookingInfoScreenState createState() => _BookingInfoScreenState();
}

class _BookingInfoScreenState extends State<BookingInfoScreen> {
  List<Map<String, dynamic>> bookings = [
    {
      'bookingTime': '2024-07-01 10:00 AM',
      'serviceType': 'Polishing',
      'customerName': 'Warsan',
      'status': 'Confirmed',
    },
    {
      'bookingTime': '2024-07-05 02:00 PM',
      'serviceType': 'Foaming',
      'customerName': 'ALi',
      'status': 'Pending',
    },
    {
      'bookingTime': '2024-07-08 09:00 AM',
      'serviceType': 'Foaming',
      'customerName': 'Nuux',
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Booking Detail',
          style: TextStyle(color: Color(0xFF4713A3)),
        ),
        iconTheme: IconThemeData(color: Color(0xFF4713A3) , size: 30,),
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
