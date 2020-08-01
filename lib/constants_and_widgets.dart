import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff6c757d);
const Color deseasedColor = Color(0xff6d7c7e);
const Color increaseInDeseasedColor = Color(0xffa4a8ae);
const Color backgroundDeseasedColor = Color(0xfff6f6f7);
const Color confirmedCasescolor = Color(0xfff9103c);
const Color increaseInConfirmedCasescolor = Color(0xfffa5b82);
const Color backgroundConfirmedCasesColor = Color(0xfffddfe7);
const Color activeCasesColor = Color(0xff177cff);
const Color backgroundActiveCasesColor = Color(0xffd2e7ff);
const Color recoveredColor = Color(0xff28a744);
const Color increaseInRecoveryColor = Color(0xff68c68a);
const Color backgroundRecoverevColor = Color(0xffe1f4e8);
const Color testedColor = Color(0xff4d21aa);
const Color increaseInTestedColor = Color(0xff706fc5);
const Color backgroundTestedColor = Color(0xffe3e3f4);
const TextStyle smallFontTextstyle = TextStyle(fontWeight: FontWeight.w900);

class SelectionWidget extends StatelessWidget {
  SelectionWidget({this.itemList, this.onChanged, this.hint});

  final List<DropdownMenuItem<String>> itemList;
  final Function onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 12.0, top: 4.0, bottom: 4.0, right: 12.0),
        height: 60,
        color: primaryColor,
        child: DropdownButton<String>(
          isExpanded: true,
          elevation: 5,
          dropdownColor: Colors.grey[300],
          items: itemList,
          onChanged: onChanged,
          hint: Text(
            hint,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.w900),
          ),
        ));
  }
}

class DataTile extends StatelessWidget {
  DataTile({
    this.backgroundColor,
    this.increaseInData,
    this.mainTextColor,
    this.sideTextColor,
    this.totalData,
    this.type,
    this.icon = Icons.arrow_upward,
  });

  final Color backgroundColor;
  final Color mainTextColor;
  final Color sideTextColor;
  final String type;
  final String totalData;
  final String increaseInData;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
          padding: EdgeInsets.all(8),
          height: 100,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(2.0,2.0),
                blurRadius: 5,
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                type,
                style: TextStyle(
                    color: mainTextColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    totalData,
                    style: TextStyle(
                      fontSize: 35,
                      color: mainTextColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Icon(
                    icon,
                    size: 25,
                    color: sideTextColor,
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Text(
                    increaseInData,
                    style: TextStyle(
                      fontSize: 22,
                      color: sideTextColor,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
