import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Importing the intl package for date formatting

class BookNowScreen extends StatefulWidget {
  @override
  _BookNowScreenState createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  String customerName = "";
  String telephone = "";
  String carDetail = "";
  String carTargo = "";
  bool option1 = false;
  bool option2 = false;
  bool option3 = false;
  DateTime? selectedDate;
  String? selectedCarType; // State variable for selected dropdown value
  List<String> carTypes = ['Luxury Cars', 'Normal Cars', 'Trucks']; // Dropdown values

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double additionalServicePrice = 0.0;

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
                buildDropdownField(), // Adjusted padding for dropdown field
                SizedBox(height: 30),
                Container(
                  width: screenWidth, // Match the width of the screen
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: Color(0xFF4713A3),
                    ),
                  ),
                  padding: EdgeInsets.all(20), // Padding adjusted to 20
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Additional Services:',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      buildCheckBox(
                        'Foaming',
                        option1,
                        (bool? value) {
                          setState(() {
                            option1 = value!;
                            updateAdditionalServicePrice();
                          });
                        },
                      ),
                      buildCheckBox(
                        'Oil Change',
                        option2,
                        (bool? value) {
                          setState(() {
                            option2 = value!;
                            updateAdditionalServicePrice();
                          });
                        },
                      ),
                      buildCheckBox(
                        'Polishing',
                        option3,
                        (bool? value) {
                          setState(() {
                            option3 = value!;
                            updateAdditionalServicePrice();
                          });
                        },
                      ),
                    ],
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
          selectedDate == null ||
          selectedCarType == null ||
          (!option1 && !option2 && !option3)) {
        // If any input is empty or no additional service is selected, show error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please fill in all the fields and select at least one additional service.'),
          backgroundColor: Colors.red,
        ));
      } else {
        // Calculate total price including additional services
        double totalPrice = calculateTotalPrice();

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
              selectedCarType: selectedCarType!,
              option1: option1,
              option2: option2,
              option3: option3,
              totalPrice: totalPrice,
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
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget buildDropdownField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: Color(0xFF4713A3),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Adjusted padding for dropdown
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
        ),
        value: selectedCarType,
        hint: Text('Select Car Type', style: TextStyle(fontSize: 20)),
        onChanged: (newValue) {
          setState(() {
            selectedCarType = newValue!;
            updateAdditionalServicePrice(); // Update price when car type changes
          });
        },
        items: carTypes.map((type) {
          return DropdownMenuItem(
            value: type,
            child: Text(type),
          );
        }).toList(),
      ),
    );
  }

  void updateAdditionalServicePrice() {
    // Reset price
    additionalServicePrice = 0.0;

    // Calculate based on selected car type and options
    if (selectedCarType == 'Luxury Cars') {
      if (option1) {
        additionalServicePrice += 10.0; // Foaming
      }
      if (option2) {
        additionalServicePrice += 8.0; // Oil Change
      }
      if (option3) {
        additionalServicePrice += 20.0; // Polishing
      }
    } else if (selectedCarType == 'Normal Cars') {
      if (option1) {
        additionalServicePrice += 5.0; // Foaming
      }
      if (option2) {
        additionalServicePrice += 8.0; // Oil Change
      }
      if (option3) {
        additionalServicePrice += 10.0; // Polishing
      }
    } else if (selectedCarType == 'Trucks') {
      if (option1) {
        additionalServicePrice += 16.0; // Foaming
      }
      if (option2) {
        additionalServicePrice += 8.0; // Oil Change
      }
      if (option3) {
        additionalServicePrice += 30.0; // Polishing
      }
    }

    setState(() {
      // Update UI with calculated price
    });
  }

  double calculateTotalPrice() {
    // Calculate total price including additional services
    double totalPrice = 0.0;

    // Base price calculation (if any)

    // Add additional services price
    totalPrice += additionalServicePrice;

    return totalPrice;
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
  final bool option3;
  final String selectedCarType;
  final double totalPrice;

  ConfirmationScreen({
    required this.customerName,
    required this.telephone,
    required this.carDetail,
    required this.carTargo,
    required this.selectedDate,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.selectedCarType,
    required this.totalPrice,
  });

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  int totalItems = 0;

  @override
  void initState() {
    super.initState();
    // Calculate initial total items based on selected options
    if (widget.option1) totalItems++;
    if (widget.option2) totalItems++;
    if (widget.option3) totalItems++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirmation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF4713A3),
        iconTheme: IconThemeData(color: Colors.white, size: 30),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
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
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Customer Name : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.customerName}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Telephone : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.telephone}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Car Detail : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.carDetail}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Car Targo : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.carTargo}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Date & Time : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        '${DateFormat.yMd().add_jm().format(widget.selectedDate)}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Selected Car Type : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.selectedCarType}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            Text(
              'Additional Services :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (widget.option1) ...[
              Text('Foaming', style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
            ],
            if (widget.option2) ...[
              Text('Oil Change', style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
            ],
            if (widget.option3) ...[
              Text('Polishing', style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
            ],
            SizedBox(height: 20),
            Divider(height: 2, thickness: 2, color: Colors.grey),
            SizedBox(height: 20),
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
                          color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Total Price :',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${totalItems == 0 ? 'No items' : (totalItems == 1 ? '1 item' : '$totalItems items')}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '\$${widget.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
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
                backgroundColor: Color(0xFF4713A3),
                padding: EdgeInsets.all(16),
                minimumSize: Size(double.infinity, 0),
              ),
              child: Text(
                'Pay Now',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BookNowScreen(),
  ));
}
