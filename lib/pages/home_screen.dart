import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginassegmnt/pages/luxury_polishing.dart';
import 'booking_info.dart';
import 'settings_screen.dart';
import 'normal_polishing.dart';
import 'Tracks_polishing.dart';
import 'luxury_foaming.dart';
import 'normal_foaming.dart';
import 'Tracks_foaming.dart';
import 'luxury_oilchange.dart';
import 'normal_oilchange.dart';
import 'Tracks_oilchange.dart';
import 'aboutus.dart';
import 'profile.dart';
import 'cus_support.dart';
import 'BookNow.dart';
import 'Check_Avalability.dart';
import 'notifications.dart';
import 'NotificationBadge.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String email;

  HomeScreen({Key? key, required this.username, required this.email}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }

  int _selectedIndex = 0;

  static late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomeScreen(username: widget.username, email: widget.email),
      BookNowScreen(),
      CustomerSupportScreen(),
      ProfileScreen(username: widget.username, email: widget.email),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _widgetOptions[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    int notificationCount = 3; // Replace with your actual notification count

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'eWash',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Color(0xFF4713A3),
          ),
        ),
       actions: [
          NotificationBadge(
            notificationCount: notificationCount,
            onTap: () {
              _showNotificationPage(context);
            },
          ),
        ],
        iconTheme: IconThemeData(color: Color(0xFF4713A3), size: 30),
      ),
           drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF4713A3),
              ),
              child: Image.asset(
          'images/Capture.PNG', // Replace 'your_image.png' with your image asset path
          width: screenSize.width * 0.2, // Set the width of the image based on screen width
          height: screenSize.width * 0.2, // Set the height of the image based on screen width
          fit: BoxFit.cover, // Adjust the fit of the image within the available space
        ),
            ),
                         ListTile(
              leading: Icon(Icons.home , color: Color(0xFF4713A3),),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(username: widget.username, email: widget.email)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info_sharp, color: Color(0xFF4713A3),),
              title: Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()),
                );
              },
            ),
            
  ListTile(
              leading: Icon(Icons.description , color: Color(0xFF4713A3),),
              title: Text('Book Now'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookNowScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.event , color: Color(0xFF4713A3),),
              title: Text('YourBooking Info'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingInfoScreen(),
                  ),
                );
              },
            ),
               ListTile(
              leading: Icon(Icons.event , color: Color(0xFF4713A3),),
              title: Text('Check Availability'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckAvailabilityScreen(),
                  ),
                );
              },
            ),
          
             ListTile(
              leading: Icon(Icons.support_agent , color: Color(0xFF4713A3),),
              title: Text('Customer Support'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerSupportScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications , color: Color(0xFF4713A3),),
              title: Text('Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
            ),
        ListTile(
              leading: Icon(Icons.person , color: Color(0xFF4713A3),),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen(username: widget.username, email: widget.email)),
                );
              },
            ),
          ListTile(
              leading: Icon(Icons.settings , color: Color(0xFF4713A3),),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout, color: Color(0xFF4713A3),),
              onTap: () {
                _signOut(context);
              },
            ),
          ],
        ),
      ),// Setting menu icon color
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF4713A3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // Only shadow at the bottom
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Welcome! ${widget.username}',
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.07,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                '${widget.email}',

                                style: TextStyle(
                                  fontSize: screenSize.width * 0.04,
                                  color: Color.fromARGB(255, 248, 241, 241),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                _showDialog(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white), // Set background color to white
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF4713A3)), // Set text color
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Text(
                                  'BOOK NOW',
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.all(0.25),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  20), // Top left corner remains circular
                              bottomLeft: Radius.circular(
                                  20), // Bottom left corner remains circular
                              topRight: Radius.circular(
                                  0), // Top right corner becomes square
                              bottomRight: Radius.circular(
                                  0), // Bottom right corner becomes square
                            ),
                            child: Container(
                              color: Colors
                                  .white, // White background color
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Image.asset(
                                  "images/home.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Services',
                style: TextStyle(
                  fontSize: screenSize.width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4713A3),
                ),
              ),
            ),
            SizedBox(height: 10),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    height: screenSize.height *
                        0.05, // Adjust the height of the tab bar
                    child: TabBar(
                      indicatorWeight: 6,
                      labelColor: Color(0xFF4713A3),
                      indicatorColor: Color(0xFF4713A3),
                      labelStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      tabs: [
                        Tab(text: 'Polishing'),
                        Tab(text: 'Foaming'),
                        Tab(text: 'Oil Change'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: screenSize.height * 0.5,
                    child: TabBarView(
                      children: [
                        // Tab view for Polishing
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.05),
                            child: Column(
                              children: [
                                _buildItem(
                                  title: 'Luxury Cars',
                                  subtitle: 'Free Yr Car from Dirt',
                                  subtitle2: 'Available',
                                  price: '\$20.00',
                                  color: Color(0xFF4713A3),
                                  context: context,
                                  imagePath: 'images/i.png',
                                  nextPage: PolishingScreen(),
                                ),
                                _buildItem(
                                  title: 'Normal Cars',
                                  subtitle: 'Free Yr Car from Dirt',
                                  subtitle2: 'Available',
                                  price: '\$10.00',
                                  color: Color(0xFF4713A3),
                                  context: context,
                                  imagePath: 'images/aa.jpg',
                                  nextPage: NormalScreen(),
                                ),
                                _buildItem(
                                  title: 'Truck Cars',
                                  subtitle: 'Free Yr Car from Dirt',
                                  subtitle2: 'Available',
                                  price: '\$30.00',
                                  color: Color(0xFF4713A3),
                                  context: context,
                                  imagePath: 'images/service3.jpg',
                                  nextPage: TracksPolishingScreen(),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Tab view for Foaming
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.05),
                            child: Column(
                              children: [
                                _buildItem(
                                  title: 'Luxury Cars',
                                  subtitle: 'Free Yr Car from Dirt',
                                  subtitle2: 'Available',
                                  price: '\$10.00',
                                  color: Color(0xFF4713A3),
                                  context: context,
                                  imagePath: 'images/i.png',
                                  nextPage: LuxuryFoamingScreen(),
                                ),
                                _buildItem(
                                  title: 'Normal Cars',
                                  subtitle: 'Free Yr Car from Dirt',
                                  subtitle2: 'Available',
                                  price: '\$5.00',
                                  color: Color(0xFF4713A3),
                                  context: context,
                                  imagePath: 'images/aa.jpg',
                                  nextPage: NormalFoamingScreen(),
                                ),
                                _buildItem(
                                  title: 'Truck Cars',
                                  subtitle: 'Free Yr Car from Dirt',
                                  subtitle2: 'Available',
                                  price: '\$16.00',
                                  color: Color(0xFF4713A3),
                                  context: context,
                                  imagePath: 'images/service3.jpg',
                                  nextPage: TracksFoamingScreen(),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Tab view for Oil Change
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.05),
                            child: Column(
                              children: [
                                _buildItem(
                                  title: 'Luxury Cars',
                                  subtitle: 'Free Yr Car from Dirt',
                                  subtitle2: 'Available',
                                  price: '\$8.00',
                                  color: Color(0xFF4713A3),
                                  context: context,
                                  imagePath: 'images/toyota-land-cruiser-prado-car.png',
                                  nextPage: LuxuryOilChangeScreen(),
                                ),
                                _buildItem(
                                  title: 'Normal Cars',
                                  subtitle: 'Free Yr Car from Dirt',
                                  subtitle2: 'Available',
                                  price: '\$8.00',
                                  color: Color(0xFF4713A3),
                                  context: context,
                                  imagePath: 'images/aa.jpg',
                                  nextPage: NormalOilChangeScreen(),
                                ),
                                _buildItem(
                                  title: 'Truck Cars',
                                  subtitle: 'Free Yr Car from Dirt',
                                  subtitle2: 'Available',
                                  price: '\$8.00',
                                  color: Color(0xFF4713A3),
                                  context: context,
                                  imagePath: 'images/service3.jpg',
                                  nextPage: TracksOilChangeScreen(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Book Now',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'HelpLine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: screenSize.width * 0.04,
        selectedIconTheme:
            IconThemeData(color: Colors.amberAccent, size: 30),
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: _onItemTapped,
        backgroundColor: Color(0xFF4713A3),
      ),
    );
  }

  Widget _buildItem({
    required String title,
    required String subtitle,
    required String subtitle2,
    required String price,
    required Color color,
    required BuildContext context,
    required String imagePath,
    required Widget nextPage, // Add this parameter
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage(imagePath),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      subtitle2,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  price,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('You have requested our service. Are you sure?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Navigate to AppointmentsScreen when 'Yes' is selected
              Navigator.pushReplacement( // Use pushReplacement instead of push
                context,
                MaterialPageRoute(builder: (context) => BookNowScreen()),
              );
            },
            child: Text(
              'Yes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigate to HomeScreen when 'No' is selected
              Navigator.pop(context, false); // Pop the dialog
            },
            child: Text(
              'No',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      );
    },
  ).then((value) {
    if (value != null && value) {
      print('Washing your car...');
    } else {
      print('Cancelled washing.');
    }
  });
}


  void _showNotificationPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NotificationPage(), // Navigate to NotificationPage
    ),
  );
}
}

class DoctorSearchDelegate extends SearchDelegate<String> {
  final List<String> doctorImages;

  DoctorSearchDelegate(this.doctorImages);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSuggestions(context);
  }

  Widget _buildSuggestions(BuildContext context) {
    final List<String> suggestionList = query.isEmpty
        ? doctorImages
        : doctorImages
            .where((element) => element.toLowerCase().contains(query))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            query = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
