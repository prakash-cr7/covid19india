import 'package:flutter/material.dart';
import 'constants_and_widgets.dart';
import 'about_screen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  bool notificatonState = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: primaryColor,
        child: ListView(
          children: <Widget>[
            GestureDetector(
                child: Card(
                  color: primaryColor,
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                    child: Text(
                      'Change Your Location',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
            ),
            Card(
              color: primaryColor,
              child: SwitchListTile(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Dark mode',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      '(Coming soon)',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                activeColor: Colors.black,
                value: false,
                onChanged: null,
              ),
            ),
            Card(
              color: primaryColor,
              child: SwitchListTile(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                title: Text(
                  'Receive Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.left,
                ),
                activeColor: Colors.black,
                value: notificatonState,
                onChanged: (value){
                  setState(() {
                    notificatonState = value;

                  });
                },

              ),
            ),
            GestureDetector(
              child: Card(
                color: primaryColor,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  child: Text(
                    'About',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> About()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
