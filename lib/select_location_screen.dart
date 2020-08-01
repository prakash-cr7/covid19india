import 'package:covid19india/main_screen.dart';
import 'location_data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants_and_widgets.dart';
import 'get_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLocationScreen extends StatefulWidget {
  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  String selectedState;
  String selecteddistrict;
  String stateHintText = 'Select Your State';
  String districtHintText = 'Select Your District';

  SharedPreferences _sharedPreferences;

  List<DropdownMenuItem<String>> stateList() {
    List<DropdownMenuItem<String>> list = [];
    for (int i = 0; i < 35; i++) {
      list.add(DropdownMenuItem(
        child: Text(countryData['states'][i]['state']),
        value: countryData['states'][i]['state'],
      ));
    }
    return list;
  }

  List<DropdownMenuItem<String>> districtList;
  void getDistrictList() {
    if (selectedState != null) {
      for (var district in countryData['states'][stateIndex[selectedState]]
          ['districts']) {
        districtList.add(DropdownMenuItem(
          child: Text(district),
          value: district,
        ));
      }
    }
  }

  @override
  void initState()  {
    initSharedPreferences();
    super.initState();
  }
  void initSharedPreferences () async {
    _sharedPreferences = await SharedPreferences.getInstance();
    getData();
  }

  void setData () {
     print('data saved');
  }

  void getData()  {
    print('function called');
    try {
      var data =  _sharedPreferences.getStringList('location');
      print(data);
      selectedState = data[0];
      selecteddistrict = data[1];
      Provider.of<Data>(context, listen: false)
          .saveLocation(selectedState, selecteddistrict);
      Provider.of<Data>(context, listen: false)
          .getLocation(selectedState, selecteddistrict);
      Provider.of<Data>(context, listen: false).getData();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MainScreen()));
    } catch (e) {
      print(e);
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'COVID19',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'INDIA',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff4c75f2)),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              SizedBox(
                height: 130,
              ),
              SelectionWidget(
                itemList: stateList(),
                hint: stateHintText,
                onChanged: (value) {
                  selectedState = value;
                  setState(() {
                    stateHintText = value;
                    districtHintText = 'Select District';
                    districtList = [];
                    getDistrictList();
                  });
                },
              ),
              SizedBox(
                height: 16,
              ),
              SelectionWidget(
                itemList: districtList,
                hint: districtHintText,
                onChanged: (value) {
                  selecteddistrict = value;
                  setState(() {
                    districtHintText = value;
                  });
                },
              ),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                padding: EdgeInsets.all(0),
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  color: activeCasesColor,
                  child: Text(
                    'Get Data',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                onPressed: () {
                  _sharedPreferences.setStringList('location', [selectedState, selecteddistrict]);
                  Provider.of<Data>(context, listen: false)
                      .saveLocation(selectedState, selecteddistrict);
                  Provider.of<Data>(context, listen: false)
                      .getLocation(selectedState, selecteddistrict);
                  Provider.of<Data>(context, listen: false).getData();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
              ),
              SizedBox(height: 80),
              Flexible(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 180,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/mask_illustration.jpg'))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
