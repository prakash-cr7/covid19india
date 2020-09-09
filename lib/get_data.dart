import 'package:covid19india/location_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class GraphData {
  GraphData({this.dateTime, this.value});
  String dateTime;
  int value;
}

class Data extends ChangeNotifier {
  String myState, myStateAcronym, myDistrict, savedState, savedDistrict;
  var decodeddata, datedDecodedData;
  final numberFormatter = NumberFormat('##,##,##,###', "en_in");

  Future getData() async {
    http.Response response =
        await http.get('https://api.covid19india.org/v4/data.json');
    if (response.statusCode == 200) {
      String data = response.body;
      decodeddata = jsonDecode(data);
    } else
      print(response.statusCode);
    notifyListeners();
  }

  Future getDatedData() async {
    http.Response response =
        await http.get('https://api.covid19india.org/v4/timeseries.json');
    if (response.statusCode == 200) {
      String data = response.body;
      datedDecodedData = jsonDecode(data);
    } else
      print(response.statusCode);
    notifyListeners();
  }

  List<String> getDates() {
    List<String> dateList = [];
    var newFormat = DateFormat("yyyy-MM-dd");
    for (int i = 30; i >= 1; i--) {
      var diff = DateTime.now().subtract(Duration(days: i, hours: 1));
      dateList.add(newFormat.format(diff));
    }
    return dateList;
  }

  List<GraphData> datedData({String stateAcronym, String type}) {
    List<GraphData> graphDataList = [];
    List<String> dates = getDates();
    try {
      for (String date in dates) {
        GraphData graphData = GraphData(
            dateTime: date,
            value: datedDecodedData[stateAcronym]['dates'][date]['delta']
                [type]);
        graphDataList.add(graphData);
      }
    } catch (e) {
      print('$e caught error in datedData');
    }
    return graphDataList;
  }

  void saveLocation(String state, String district) {
    savedState = state;
    savedDistrict = district;
  }

  void updateLocation() {
    try {
      getLocation(savedState, savedDistrict);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void getLocation(String state, String district) {
    myState = state;
    myStateAcronym = countryData['states'][stateIndex[state]]['acronym'];
    myDistrict = district;
    notifyListeners();
  }

  get getDistrict {
    if (myDistrict != null)
      return myDistrict;
    else
      return '';
  }

  get getState {
    return myState;
  }

  get getStateAcronym {
    return myStateAcronym;
  }

  String getRecoveryRate(String acronym) {
    double recoveryRate;
    try {
      recoveryRate = decodeddata[acronym]['total']['recovered'] /
          decodeddata[acronym]['total']['confirmed'] *
          100;
      return recoveryRate.toStringAsFixed(2);
    } catch (e) {
      return '';
    }
  }

  String getMortalityrate(String acronym) {
    double mortalityRate;
    try {
      mortalityRate = decodeddata[acronym]['total']['deceased'] /
          decodeddata[acronym]['total']['confirmed'] *
          100;
      return mortalityRate.toStringAsFixed(2);
    } catch (e) {
      return '';
    }
  }

  String getTestedRatio(String acronym) {
    try {
      double ratio;
      ratio = decodeddata[acronym]['total']['confirmed'] /
          decodeddata[acronym]['total']['tested'] *
          100;
      return ratio.toStringAsFixed(2);
    } catch (e) {
      return '';
    }
  }

  get getDistrictRecoveryRate {
    double recoveryRate;
    try {
      recoveryRate = decodeddata[myStateAcronym]['districts'][myDistrict]
              ['total']['recovered'] /
          decodeddata[myStateAcronym]['districts'][myDistrict]['total']
              ['confirmed'] *
          100;
      return (recoveryRate.toStringAsFixed(2) + '%');
    } catch (e) {
      return '';
    }
  }

  get getDistrictMortalityRate {
    double mortalityRate;
    try {
      mortalityRate = decodeddata[myStateAcronym]['districts'][myDistrict]
              ['total']['deceased'] /
          decodeddata[myStateAcronym]['districts'][myDistrict]['total']
              ['confirmed'] *
          100;
      return (mortalityRate.toStringAsFixed(2) + '%');
    } catch (e) {
      return '';
    }
  }

  get getDistrictTestRatio {
    double ratio;
    try {
      ratio = decodeddata[myStateAcronym]['districts'][myDistrict]['total']
              ['confirmed'] /
          decodeddata[myStateAcronym]['districts'][myDistrict]['total']
              ['tested'] *
          100;
      return (ratio.toStringAsFixed(2) + '%');
    } catch (e) {
      return '';
    }
  }

  String getStateData({String stateAcronym, String totalOrDelta, String type}) {
    int temp;
    try {
      temp = decodeddata[stateAcronym][totalOrDelta][type];
      if (temp != null)
        return numberFormatter.format(temp);
      else
        return '';
    } catch (e) {
      return '';
    }
  }

  String getDistrictData({String totalOrDelta, String type}) {
    int temp;
    try {
      temp = decodeddata[myStateAcronym]['districts'][myDistrict][totalOrDelta]
          [type];
      if (temp != null)
        return numberFormatter.format(temp);
      else
        return '';
    } catch (e) {
      return '';
    }
  }

  get getIndiatested {
    int indiaTested;
    try {
      indiaTested = decodeddata['TT']['total']['tested'];
      int temp = (indiaTested ~/ 10000000);
      int temp1 = ((indiaTested % 10000000) ~/ 100000);
      return temp.toString() + ' crore ' + temp1.toString() + ' lakh';
    } catch (e) {
      return '';
    }
  }

  get getIndiaActive {
    int indiaActive;
    try {
      indiaActive = decodeddata['TT']['total']['confirmed'] -
          (decodeddata['TT']['total']['deceased'] +
              decodeddata['TT']['total']['recovered']);
      return numberFormatter.format(indiaActive);
    } catch (e) {
      return '';
    }
  }

  get getStateActive {
    int stateActive;
    try {
      stateActive = decodeddata[myStateAcronym]['total']['confirmed'] -
          (decodeddata[myStateAcronym]['total']['deceased'] +
              decodeddata[myStateAcronym]['total']['recovered']);
      return numberFormatter.format(stateActive);
    } catch (e) {
      return '';
    }
  }

  get getDistrictActive {
    int districtActive;
    try {
      districtActive = decodeddata[myStateAcronym]['districts'][myDistrict]
              ['total']['confirmed'] -
          (decodeddata[myStateAcronym]['districts'][myDistrict]['total']
                  ['deceased'] +
              decodeddata[myStateAcronym]['districts'][myDistrict]['total']
                  ['recovered']);
      return numberFormatter.format(districtActive);
    } catch (e) {
      return '';
    }
  }
}
