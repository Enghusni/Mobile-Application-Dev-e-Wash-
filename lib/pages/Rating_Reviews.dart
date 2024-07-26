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
  List<dynamic> _reviews = [];
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchReviews();
  }

  Future<void> _submitReview() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('https://localhost:3000/api/reviews'), // Replace with your API endpoint
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
          _fetchReviews(); // Fetch reviews again to include the new review
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit review.')),
        );
      }
    }
  }

  Future<void> _fetchReviews() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse('http://192.168.43.170:5000/api/reviews=$_currentPage'), // Replace with your API endpoint
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        _reviews = responseData['docs'];
        _currentPage = responseData['page'];
        _totalPages = responseData['totalPages'];
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch reviews.')),
      );
      setState(() {
        _isLoading = false;
      });
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
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
                      labelText: 'Your feedback helps us to serve you better',
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
            SizedBox(height: screenSize.height * 0.05),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: _reviews.map((review) {
                      return ListTile(
                        title: Text(review['comment']),
                        subtitle: Text('Rating: ${review['rating']}'),
                      );
                    }).toList(),
                  ),
            SizedBox(height: screenSize.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 1)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _currentPage--;
                        _fetchReviews();
                      });
                    },
                    child: Text('Previous'),
                  ),
                if (_currentPage < _totalPages)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _currentPage++;
                        _fetchReviews();
                      });
                    },
                    child: Text('Next'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
