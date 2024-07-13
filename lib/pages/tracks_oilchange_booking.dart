import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Importing the intl package for date formatting

class ServiceOption {
  final String name;
  final double amount;

  ServiceOption(this.name, this.amount);
}

class TracksOilChangeBookingScreen extends StatefulWidget {
  @override
  _TracksOilChangeBookingScreenState createState() =>
      _TracksOilChangeBookingScreenState();
}

class _TracksOilChangeBookingScreenState extends State<TracksOilChangeBookingScreen> {
  String customerId = "";
  String telephone = "";
  DateTime? selectedDateTime;
  String? enteredService;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<ServiceOption> serviceOptions = [
    ServiceOption('OilChange', 8),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Process',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF4713A3), // Set app bar background color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30),
                buildInputField(
                  hintText: 'Enter Customer ID',
                  fontSize: 20,
                  onChanged: (value) {
                    setState(() {
                      customerId = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                buildInputField(
                  hintText: 'Enter Service Name',
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  ],
                  fontSize: 20,
                  onChanged: (value) {
                    setState(() {
                      enteredService = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                buildInputField(
                  hintText: 'Enter Telephone Number',
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  fontSize: 20,
                  onChanged: (value) {
                    setState(() {
                      telephone = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                buildDateTimePicker(),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (customerId.isEmpty ||
                          enteredService == null ||
                          telephone.isEmpty ||
                          selectedDateTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please fill in all the fields.'),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmationScreen(
                              customerId: customerId,
                              serviceType: enteredService!,
                              telephone: telephone,
                              selectedDateTime: selectedDateTime!,
                              serviceOptions: serviceOptions,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4713A3),
                    padding: EdgeInsets.all(16),
                  ),
                  child: Text(
                    'Check Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required String hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    required ValueChanged<String> onChanged,
    double? fontSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: Color(0xFF4713A3),
            ),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF4713A3)),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              hintStyle: TextStyle(fontSize: fontSize ?? 20),
            ),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget buildDateTimePicker() {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        ).then((pickedDate) {
          if (pickedDate == null) return;
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((pickedTime) {
            if (pickedTime == null) return;
            setState(() {
              selectedDateTime = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
            });
          });
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xFF4713A3),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDateTime != null
                  ? DateFormat.yMd().add_jm().format(selectedDateTime!)
                  : 'Select Date and Time',
              style: TextStyle(fontSize: 20),
            ),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}

class ConfirmationScreen extends StatelessWidget {
  final String customerId;
  final String serviceType;
  final String telephone;
  final DateTime selectedDateTime;
  final List<ServiceOption> serviceOptions;

  ConfirmationScreen({
    required this.customerId,
    required this.serviceType,
    required this.telephone,
    required this.selectedDateTime,
    required this.serviceOptions,
  });

  double getTotalPrice() {
    double total = 0;
    for (var option in serviceOptions) {
      total += option.amount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final double totalPrice = getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirmation',
          style: TextStyle(color: Colors.white , fontSize: 25),
        ),
        backgroundColor: Color(0xFF4713A3),
        iconTheme: IconThemeData(size: 25 , color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                decoration: BoxDecoration(
                  color: Color(0xFF4713A3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Your Booking Details',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Please review your booking details',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              buildDetailRow('Customer ID', customerId),
              buildDetailRow('Service Type', serviceType),
              buildDetailRow('Telephone', telephone),
              buildDetailRow(
                'Date and Time',
                DateFormat.yMd().add_jm().format(selectedDateTime),
              ),
              SizedBox(height: 50),
              Divider(height: 1, color: Color(0xFF4713A3)),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  // Perform checkout action here
                  // For now, let's just go back to the previous screen
                  //Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4713A3),
                  padding: EdgeInsets.all(16),
                  minimumSize: Size(double.infinity, 0), // Set button width to full width
                ),
                child: Text(
                  'Pay Now',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '$title :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: TracksOilChangeBookingScreen(),
  ));
}
