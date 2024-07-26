import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';

void main() {
  runApp(MaterialApp(
    home: NormalPolishBookingScreen(),
  ));
}

class ServiceOption {
  final String name;
  final double amount;

  ServiceOption(this.name, this.amount);
}

class NormalPolishBookingScreen extends StatefulWidget {
  @override
  _NormalPolishBookingScreenState createState() =>
      _NormalPolishBookingScreenState();
}

class _NormalPolishBookingScreenState extends State<NormalPolishBookingScreen> {
  List<ServiceOption> selectedServices = [];
  DateTime? selectedDateTime;
  String customerId = ''; // Replace with actual customer ID
  String telephone = ''; // Telephone number text field

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _telephoneController = TextEditingController();

  List<ServiceOption> serviceOptions = [
    ServiceOption('Normal Car Polishing', 10),
    // Uncomment and adjust if needed
    // ServiceOption('Normal Car Polishing, foaming', 15),
    // ServiceOption('Truck Car Polishing, foaming', 46),
    ServiceOption('Oil Change', 8),
  ];

  String generateTransactionNumber() {
    var uuid = Uuid();
    return uuid.v4(); // Generate a version 4 (random) UUID
  }

  double getTotalPrice() {
    return selectedServices.fold(0, (total, service) => total + service.amount);
  }

  Future<void> submitBooking() async {
    if (_formKey.currentState!.validate()) {
      if (selectedServices.isEmpty || selectedDateTime == null || _telephoneController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select services, date & time, and enter your telephone number.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      String transactionNumber = generateTransactionNumber();
      double totalAmount = getTotalPrice(); // Calculate total amount based on selected services

      final url = Uri.parse('http://your-backend-url/api/bookings'); // Replace with your backend URL

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'customer': customerId, // Assuming customerId is used as user name
            'services': selectedServices.map((service) => service.name).toList(),
            'telephone': _telephoneController.text,
            'dateTime': selectedDateTime!.toIso8601String(),
            'tn': transactionNumber,
            'amount': totalAmount,
          }),
        );

        if (response.statusCode == 201) {
          // Booking successful, handle navigation or feedback
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Booking successful!'),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to success screen or home screen
        } else {
          // Handle errors if booking fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Booking failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        // Handle network or server errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _telephoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Process',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xFF4713A3),
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
                buildServiceSelector(),
                SizedBox(height: 30),
                buildDateTimePicker(),
                SizedBox(height: 20), // Add spacing between date picker and telephone field
                TextFormField(
                  controller: _telephoneController,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Telephone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF4713A3)),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your telephone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: submitBooking,
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

  Widget buildServiceSelector() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: Color(0xFF4713A3),
        ),
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Services:', style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          ...serviceOptions.map((service) {
            return buildCheckBox(
              service.name,
              selectedServices.contains(service),
              (bool? value) {
                setState(() {
                  if (value!) {
                    selectedServices.add(service);
                  } else {
                    selectedServices.remove(service);
                  }
                });
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget buildCheckBox(String title, bool isChecked, ValueChanged<bool?> onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
        ),
        Text(title),
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
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF4713A3)),
          borderRadius: BorderRadius.circular(10),
        ),
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
