import 'package:covid19india/constants_and_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  final Color textColor = Colors.grey[300];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('About'),
      ),
      backgroundColor: primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Developer',
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontSize: 35, color: textColor),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Prakash Kumar',
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontSize: 30, color: textColor),
            ),
            Text(
              'Email: prakashkumarraj1@gmail.com',
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontSize: 15, color: textColor),
            ),
            SizedBox(height: 40),
            Text(
              'Data Source',
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontSize: 35, color: textColor),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'covid19india.org',
              style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 30, color: textColor),
            ),
            Text(
              'covid19india.org is an opensource website which provides latest data on Coronavirus cases in India.',
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontSize: 15, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
