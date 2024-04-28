// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class AdminWaiting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Set background color
      appBar: AppBar(
        title: Text(
          'Activter compte étudiant',
          style: TextStyle(color: Colors.white), // Change app bar text color
        ),
        backgroundColor: Colors.blue, // Change app bar background color
        elevation: 0, // Remove app bar shadow
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blue), // Change loading indicator color
            ),
            SizedBox(height: 20),
            Text(
              'Please wait...',
              style: TextStyle(
                  fontSize: 18, color: Colors.blue), // Change text color
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle cancellation or navigation to other screens
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(
                    255, 177, 118, 244), // Change button background color
                onPrimary: Colors.white, // Change button text color
              ),
              child: Text('Cancel'), // Option to cancel the activity
            ),
          ],
        ),
      ),
    );
  }
}
