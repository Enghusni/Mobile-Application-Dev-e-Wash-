import 'package:flutter/material.dart';

void main() {
  runApp(SettingsScreen());
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool receiveNotifications = true;
  bool autoConfirmBooking = false;
  bool darkModeEnabled = false;
  bool rememberCredentials = true;
  bool syncDataEnabled = true;
  bool feedbackEnabled = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkModeEnabled ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF4713A3),
          title: Text(
            'Settings',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Notifications'),
                        _buildSwitchTile(
                          title: 'Receive Notifications',
                          value: receiveNotifications,
                          onChanged: (value) {
                            setState(() {
                              receiveNotifications = value;
                              _toggleNotificationPreference(value);
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        _buildSectionTitle('Booking Preferences'),
                        _buildSwitchTile(
                          title: 'Auto Confirm Booking',
                          value: autoConfirmBooking,
                          onChanged: (value) {
                            setState(() {
                              autoConfirmBooking = value;
                              _toggleAutoConfirmBooking(value);
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        _buildSectionTitle('Appearance'),
                        _buildSwitchTile(
                          title: 'Dark Mode',
                          value: darkModeEnabled,
                          onChanged: (value) {
                            setState(() {
                              darkModeEnabled = value;
                              _toggleDarkMode(value);
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        _buildSectionTitle('Data Sync'),
                        _buildSwitchTile(
                          title: 'Sync Data',
                          value: syncDataEnabled,
                          onChanged: (value) {
                            setState(() {
                              syncDataEnabled = value;
                              _toggleDataSync(value);
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        _buildSectionTitle('Feedback'),
                        _buildSwitchTile(
                          title: 'Provide Feedback',
                          value: feedbackEnabled,
                          onChanged: (value) {
                            setState(() {
                              feedbackEnabled = value;
                              _toggleFeedback(value);
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        _buildSectionTitle('Security'),
                        _buildSwitchTile(
                          title: 'Remember Credentials',
                          value: rememberCredentials,
                          onChanged: (value) {
                            setState(() {
                              rememberCredentials = value;
                              _toggleRememberCredentials(value);
                            });
                          },
                        ),
                      ],
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

  void _toggleNotificationPreference(bool value) {
    print('Receive Notifications: $value');
  }

  void _toggleAutoConfirmBooking(bool value) {
    print('Auto Confirm Booking: $value');
  }

  void _toggleDarkMode(bool value) {
    print('Dark Mode: $value');
  }

  void _toggleDataSync(bool value) {
    print('Sync Data: $value');
  }

  void _toggleFeedback(bool value) {
    print('Provide Feedback: $value');
  }

  void _toggleRememberCredentials(bool value) {
    print('Remember Credentials: $value');
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
