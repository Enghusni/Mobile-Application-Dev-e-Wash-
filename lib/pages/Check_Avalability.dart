import 'package:flutter/material.dart';

class CheckAvailabilityScreen extends StatefulWidget {
  @override
  _CheckAvailabilityScreenState createState() => _CheckAvailabilityScreenState();
}

class _CheckAvailabilityScreenState extends State<CheckAvailabilityScreen> {
  List<Map<String, dynamic>> availableTimes = [
    {'dateTime': '2024-07-06 06:00 AM', 'available': true, 'serviceType': 'Foaming', 'duration': '1 hour'},
    {'dateTime': '2024-07-06 07:00 AM', 'available': false, 'serviceType': 'Polishing', 'duration': '2 hours'},
    {'dateTime': '2024-07-06 09:00 AM', 'available': true, 'serviceType': 'Oil Change', 'duration': '1.5 hours'},
    {'dateTime': '2024-07-06 10:30 AM', 'available': true, 'serviceType': 'Foaming', 'duration': '1 hour'},
    {'dateTime': '2024-07-07 11:30 AM', 'available': true, 'serviceType': 'Polishing', 'duration': '2 hours'},
    {'dateTime': '2024-07-07 01:30 PM', 'available': false, 'serviceType': 'Oil Change', 'duration': '1.5 hours'},
    {'dateTime': '2024-07-07 02:30 PM', 'available': true, 'serviceType': 'Foaming', 'duration': '1 hour'},
    {'dateTime': '2024-07-08 03:30 PM', 'available': true, 'serviceType': 'Polishing', 'duration': '2 hours'},
    {'dateTime': '2024-07-08 11:30 PM', 'available': true, 'serviceType': 'Foaming', 'duration': '1 hour'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Availability' , style: TextStyle(color: Color(0xFF4713A3)),),
        iconTheme: IconThemeData(color: Color(0xFF4713A3) , size: 30,),
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
