import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Importing the intl package for date formatting

class NormalOilChangeBookingScreen extends StatefulWidget {
  @override
  _NormalOilChangeBookingScreenState createState() =>
      _NormalOilChangeBookingScreenState();
}

class _NormalOilChangeBookingScreenState extends State<NormalOilChangeBookingScreen> {
  String customerName = "";
  String telephone = "";
  String carDetail = "";
  String carTargo = "";
  bool option1 = false;
  bool option2 = false;
  DateTime? selectedDate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  hintText: 'Enter Your FullName',
                  onChanged: (value) {
                    setState(() {
                      customerName = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                buildInputField(
                  hintText: 'Enter Your Telephone',
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) {
                    setState(() {
                      telephone = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                buildInputField(
                  hintText: 'Enter Your Car Detail',
                  onChanged: (value) {
                    setState(() {
                      carDetail = value;
                    });
                  },
                  exampleText: 'for example: SURF CAR MODEL 2018',
                ),
                SizedBox(height: 30),
                buildInputField(
                  hintText: 'Enter Your Car Number',
                  onChanged: (value) {
                    setState(() {
                      carTargo = value;
                    });
                  },
                  exampleText: 'for example: AH17684',
                ),
                SizedBox(height: 30),
                buildDateTimePicker(),
                SizedBox(height: 30),
                Center(
                  child: Container(
                    width: screenWidth * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Color(0xFF4713A3),
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Additional Services:',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildCheckBox(
                              'Oil Change',
                              option1,
                              (bool? value) {
                                setState(() {
                                  option1 = value!;
                                });
                              },
                            ),
                            SizedBox(width: 20),
                            buildCheckBox(
                              'Foaming',
                              option2,
                              (bool? value) {
                                setState(() {
                                  option2 = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (customerName.isEmpty ||
                          telephone.isEmpty ||
                          carDetail.isEmpty ||
                          carTargo.isEmpty ||
                          selectedDate == null) {
                        // If any input is empty, show error message
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please fill in all the fields.'),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        // Navigate to confirmation screen with booking details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmationScreen(
                              customerName: customerName,
                              telephone: telephone,
                              carDetail: carDetail,
                              carTargo: carTargo,
                              selectedDate: selectedDate!,
                              option1: option1,
                              option2: option2,
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
    String? exampleText,
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
              hintStyle: TextStyle(fontSize: 20),
            ),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
          ),
        ),
        if (exampleText != null)
          Padding(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Text(
              exampleText,
              style: TextStyle(color: Colors.grey),
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
              selectedDate = DateTime(
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
              selectedDate != null
                  ? DateFormat.yMd().add_jm().format(selectedDate!)
                  : 'Select Date and Time',
              style: TextStyle(fontSize: 20),
            ),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Widget buildCheckBox(
    String title,
    bool value,
    ValueChanged<bool?> onChanged,
  ) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

class ConfirmationScreen extends StatefulWidget {
  final String customerName;
  final String telephone;
  final String carDetail;
  final String carTargo;
  final DateTime selectedDate;
  final bool option1;
  final bool option2;

  const ConfirmationScreen({
    required this.customerName,
    required this.telephone,
    required this.carDetail,
    required this.carTargo,
    required this.selectedDate,
    required this.option1,
    required this.option2,
  });

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  bool isLoading = false;
  bool orderCompleted = false;

  @override
  Widget build(BuildContext context) {
    // Calculating total items selected
    int totalItems = (widget.option1 ? 1 : 0) + (widget.option2 ? 1 : 0);

    // Calculating total price
    double totalPrice = 0;
    if (widget.option1) totalPrice += 8; // Price for Oil Change
    if (widget.option2) totalPrice += 5; // Price for Foaming

    // Function to save booking details to Firestore
    void saveBookingDetails() {
      setState(() {
        isLoading = true;
      });

      // Simulate a 2-second delay for demonstration purposes
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
          orderCompleted = true; // Set orderCompleted to true after successful completion
        });

        // Show snackbar for order completion
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order completed!'),
            backgroundColor: Colors.green,
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirmation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF4713A3),
        iconTheme: IconThemeData(
          color: Colors.white, size: 30,// Change this color to white
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
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
              Row(
                children: [
                  Text(
                    'Customer Name :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${widget.customerName}',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Telephone Number :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${widget.telephone}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Car Detail :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${widget.carDetail}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Car Targo :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${widget.carTargo}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Date and Time :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${DateFormat.yMd().add_jm().format(widget.selectedDate)}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Oil Change :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${widget.option1 ? 'Yes' : 'No'}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Foaming :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${widget.option2 ? 'Yes' : 'No'}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: isLoading || orderCompleted
                      ? null
                      : () {
                          // Call function to save booking details
                          saveBookingDetails();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4713A3), // Set the background color to blue
                    padding: EdgeInsets.all(16),
                  ),
                  child: Text(
                    isLoading ? 'Processing...' : (orderCompleted ? 'Order Completed' : 'Complete Order'),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF4713A3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
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
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Items :',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Total Price :',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              '${totalItems == 1 ? '1 item' : '$totalItems items'}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 20),
                            Text(
                              '\$${totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Perform checkout action here
                        // For now, let's just go back to the previous screen
                        //Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.all(16),
                        minimumSize:
                            Size(double.infinity, 0), // Set button width to full width
                      ),
                      child: Text(
                        'Pay Now',
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF4713A3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void main() {
  runApp(MaterialApp(
    home: NormalOilChangeBookingScreen(),
  ));
}
