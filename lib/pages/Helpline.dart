// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:async';

// class HelplineScreen extends StatefulWidget {
//   @override
//   _HelplineScreenState createState() => _HelplineScreenState();
// }

// class _HelplineScreenState extends State<HelplineScreen> {
//   String _currentTime = '';

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentTime();
//   }

//   void _getCurrentTime() {
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         _currentTime = _formatTime(DateTime.now());
//       });
//     });
//   }

//   String _formatTime(DateTime time) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     int hour = time.hour;
//     String period = 'AM';

//     if (hour >= 12) {
//       period = 'PM';
//       hour -= 12;
//     }

//     if (hour == 0) {
//       hour = 12;
//     }

//     return "${twoDigits(hour)}:${twoDigits(time.minute)}:${twoDigits(time.second)} $period";
//   }

//   void _callNumber() async {
//     const phoneNumber = '+252613114335';
//     final url = 'tel:$phoneNumber';
//     try {
//       if (await canLaunch(url)) {
//         await launch(url);
//       } else {
//         throw 'Could not launch $url';
//       }
//     } catch (e) {
//       print('Error launching phone call: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF4713A3),
//         title: Text(
//           'HelpLine Center',
//           style: TextStyle(color: Colors.white),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(25.0),
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 20.0),
//               Container(
//                 width: screenSize.width * 0.5,
//                 height: screenSize.width * 0.5,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 0.3,
//                       blurRadius: 0.1,
//                       offset: Offset(0, 0),
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: Image.asset(
//                     'images/mylogin2.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               Text(
//                 'Welcome to the customer service',
//                 style: TextStyle(
//                   fontSize: screenSize.width * 0.05,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               Text(
//                 'Thank you for choosing e-Wash',
//                 style: TextStyle(
//                   fontSize: screenSize.width * 0.04,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               Text(
//                 _currentTime,
//                 style: TextStyle(
//                   fontSize: screenSize.width * 0.07,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Icon(Icons.contact_support , size: screenSize.width * 0.2, color: Color(0xFF4713A3),),
//               SizedBox(height: 20.0,),
//               ElevatedButton(
//                 onPressed: _callNumber,
//                 style: ElevatedButton.styleFrom(
//                   primary: Color(0xFF4713A3),
//                   onPrimary: Colors.white,
//                 ),
//                 child: Text(
//                   'Call Number',
//                   style: TextStyle(
//                     fontSize: screenSize.width * 0.06,
//                     color: Colors.white, // Ensure text color is white
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
