import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants_and_widgets.dart';
import 'get_data.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'INDIA',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: primaryColor,
            ),
          ),
        ),
        DataTile(
          type: 'Confirmed',
          totalData: Provider.of<Data>(context, listen: true).getIndiaConfirm,
          increaseInData:
              Provider.of<Data>(context, listen: true).getDeltaIndiaConfirm,
          backgroundColor: backgroundConfirmedCasesColor,
          mainTextColor: confirmedCasescolor,
          sideTextColor: increaseInConfirmedCasescolor,
        ),
        DataTile(
          type: 'Active',
          totalData: Provider.of<Data>(context, listen: true).getIndiaActive,
          increaseInData: '',
          backgroundColor: backgroundActiveCasesColor,
          mainTextColor: activeCasesColor,
          sideTextColor: activeCasesColor,
          icon: null,
        ),
        DataTile(
          type: 'Recovered',
          totalData: Provider.of<Data>(context, listen: true).getIndiaRecovered,
          increaseInData:
              Provider.of<Data>(context, listen: true).getDeltaIndiaRecovered,
          backgroundColor: backgroundRecoverevColor,
          mainTextColor: recoveredColor,
          sideTextColor: increaseInRecoveryColor,
        ),
        DataTile(
          type: 'Deceased',
          totalData: Provider.of<Data>(context, listen: true).getIndiaDeceased,
          increaseInData:
              Provider.of<Data>(context, listen: true).getDetaIndiaDeceased,
          backgroundColor: Colors.grey[300],
          mainTextColor: deseasedColor,
          sideTextColor: increaseInDeseasedColor,
        ),
        DataTile(
          type: 'Tested',
          totalData: Provider.of<Data>(context, listen: true).getIndiatested,
          increaseInData:
              '',
          backgroundColor: backgroundTestedColor,
          mainTextColor: testedColor,
          sideTextColor: increaseInTestedColor,
          icon: null,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text(
                'Recovery Rate: ',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: primaryColor),
              ),
              Text(
                Provider.of<Data>(context, listen: true).getRecoveryRate('TT') +
                    '%',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: recoveredColor),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text(
                'Mortality Rate: ',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: primaryColor),
              ),
              Text(
                Provider.of<Data>(context, listen: true)
                        .getMortalityrate('TT') +
                    '%',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: confirmedCasescolor),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text(
                'Confirmed/Tested: ',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: primaryColor),
              ),
              Text(
                Provider.of<Data>(context, listen: true).getTestedRatio('TT') +
                    '%',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: testedColor),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Chart(
          backgroundColor: backgroundConfirmedCasesColor,
          chartTitle: 'Confirmed cases',
          barColor: increaseInConfirmedCasescolor,
          graphData: Provider.of<Data>(context, listen: true).datedData(stateAcronym: 'TT', type: 'confirmed'),
        ),
        Chart(
          chartTitle: 'Recovered',
          backgroundColor: backgroundRecoverevColor,
          barColor: increaseInRecoveryColor,
          graphData: Provider.of<Data>(context, listen: true).datedData(stateAcronym: 'TT', type: 'recovered'),
        ),
        Chart(
          chartTitle: 'Deceased',
          backgroundColor: backgroundDeseasedColor,
          barColor: increaseInDeseasedColor,
          graphData: Provider.of<Data>(context, listen: true).datedData(stateAcronym: 'TT', type: 'deceased'),
        ),
        Chart(
          chartTitle: 'Tested',
          backgroundColor: backgroundTestedColor,
          barColor: increaseInTestedColor,
          graphData: Provider.of<Data>(context, listen: true).datedData(stateAcronym: 'TT', type: 'tested'),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 25,
          child: Text(
            'PLEASE WEAR MASKS!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: increaseInDeseasedColor),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}


