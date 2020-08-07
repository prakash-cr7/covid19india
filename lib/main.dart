import 'package:covid19india/select_location_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'get_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:syncfusion_flutter_core/core.dart';


void main(){
  SyncfusionLicense.registerLicense('NT8mJyc2IWhia31hfWN9Z2doanxlfGFjYWNzYmlha2lmY3MDHmgjITI4MiA7OCY+MiEhMjliEzQ+Mjo/fTA8Pg==');
  runApp(MyApp());
}

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    configre_firebace();
  }

  void setupNotification() async {
    _firebaseMessaging.getToken().then((value) {
      print(value);
    });
  }

  void configre_firebace() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Archia',
        ),
        home: SelectLocationScreen(),
      ),
    );
  }
}
