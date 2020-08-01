import 'package:flutter/material.dart';
import 'constants_and_widgets.dart';
import 'location_data_model.dart';
import 'get_data.dart';
import 'package:provider/provider.dart';

class DistrictSearchPage extends StatefulWidget {
  @override
  _DistrictSearchPageState createState() => _DistrictSearchPageState();
}

class _DistrictSearchPageState extends State<DistrictSearchPage> {
  String selectedState;
  String selecteddistrict;

  String stateHintText = 'Select Your State';
  String districtHintText = 'Select Your District';

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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SelectionWidget(
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
            itemList: stateList(),
          ),
          SizedBox(
            height: 10,
          ),
          SelectionWidget(
            hint: districtHintText,
            onChanged: (value) {
              selecteddistrict = value;
              setState(() {
                districtHintText = value;
              });
            },
            itemList: districtList,
          ),
          SizedBox(
            height: 20,
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
            onPressed: (){
              Provider.of<Data>(context, listen: false)
                  .getLocation(selectedState, selecteddistrict);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
