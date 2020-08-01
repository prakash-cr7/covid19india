import 'package:flutter/material.dart';
import 'constants_and_widgets.dart';
import 'location_data_model.dart';
import 'get_data.dart';
import 'package:provider/provider.dart';

class StateSearchPage extends StatefulWidget {
  @override
  _StateSearchPageState createState() => _StateSearchPageState();
}

class _StateSearchPageState extends State<StateSearchPage> {
  String stateHintText = 'Select State';
  String selectedState;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
              });
            },
            itemList: stateList(),
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
            onPressed: () {
              Provider.of<Data>(context, listen: false)
                  .getLocation(selectedState, '');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
