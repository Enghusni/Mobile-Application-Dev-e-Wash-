import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewPageScreen extends StatefulWidget {
  final String userId;
  final String serviceId;

  ReviewPageScreen({Key? key, required this.userId, required this.serviceId}) : super(key: key);

  @override
  _ReviewPageScreenState createState() => _ReviewPageScreenState();
}

class _ReviewPageScreenState extends State<ReviewPageScreen> {
  final _formKey = GlobalKey<FormState>();
  double _rating = 1;
  String _comment = '';

  Future<void> _submitReview() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('https://localhost:3000/api/reviews'),  // Replace with your API endpoint
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': widget.userId,
          'serviceId': widget.serviceId,
          'rating': _rating,
          'comment': _comment,
          'dateTime': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Review submitted!')),
        );

        _formKey.currentState!.reset();
        setState(() {
          _rating = 1;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit review.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4713A3),
        title: Text('Submit Review', style: TextStyle(color: Colors.white, fontSize: screenSize.width * 0.065)),
        iconTheme: IconThemeData(color: Colors.white, size: 30),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                'Rate the Service:',
                style: TextStyle(fontSize: screenSize.width * 0.05),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < _rating ? Icons.star : Icons.star_border,
                        color: Color(0xFF4713A3),
                        size: screenSize.width * 0.12,
                      ),
                      onPressed: () {
                        setState(() {
                          _rating = index + 1.0;
                        });
                      },
                    );
                  }),
                ),
              ),
              Text(
                'Rating: ${_rating.toStringAsFixed(1)}',
                style: TextStyle(fontSize: screenSize.width * 0.04),
              ),
              SizedBox(height: screenSize.height * 0.05),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Comment Us On Here',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a comment';
                  }
                  return null;
                },
                onChanged: (value) {
                  _comment = value;
                },
              ),
              SizedBox(height: screenSize.height * 0.03),
              ElevatedButton(
                onPressed: _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4713A3),
                  padding: EdgeInsets.all(screenSize.height * 0.02),
                  minimumSize: Size(double.infinity, 0),
                ),
                child: Text(
                  'Submit Review',
                  style: TextStyle(
                    fontSize: screenSize.width * 0.06,
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
}
