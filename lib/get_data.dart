import 'package:covid19india/location_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Data extends ChangeNotifier {
  String myState, myStateAcronym, myDistrict, savedState, savedDistrict;
  var decodeddata;

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
    try{
    recoveryRate = decodeddata[acronym]['total']['recovered']/decodeddata[acronym]['total']['confirmed']*100;
    return recoveryRate.toStringAsFixed(2);
    }catch(e){return '';}
  }

  String getMortalityrate(String acronym) {
    double mortalityRate;
    try{
    mortalityRate = decodeddata[acronym]['total']['deceased']/decodeddata[acronym]['total']['confirmed']*100;
    return mortalityRate.toStringAsFixed(2);}
    catch(e){return '';}

  }

  String getTestedRatio(String acronym) {
    try{
    double ratio;
    ratio = decodeddata[acronym]['total']['confirmed']/decodeddata[acronym]['total']['tested']*100;
    return ratio.toStringAsFixed(2);}
    catch(e){return '';}
  }
  
  get getDistrictRecoveryRate{
    double recoveryRate;
    try{
      recoveryRate = decodeddata[myStateAcronym]['districts'][myDistrict]
          ['total']['recovered']/decodeddata[myStateAcronym]['districts']
          [myDistrict]['total']['confirmed']*100;
          return (recoveryRate.toStringAsFixed(2) + '%');
    }catch(e){return '';}
  }

  get getDistrictMortalityRate {
    double mortalityRate;
    try{
      mortalityRate = decodeddata[myStateAcronym]['districts'][myDistrict]
          ['total']['deceased']/decodeddata[myStateAcronym]['districts']
          [myDistrict]['total']['confirmed']*100;
          return (mortalityRate.toStringAsFixed(2) + '%');
    }catch(e){return '';}
  }

  get getDistrictTestRatio{
    double ratio;
    try{
      ratio = decodeddata[myStateAcronym]['districts']
          [myDistrict]['total']['confirmed']/decodeddata[myStateAcronym]['districts'][myDistrict]
          ['total']['tested']*100;
          return (ratio.toStringAsFixed(2) + '%');
    }catch(e) {return '';}
  }
  get getIndiaConfirm {
    int indiaConfirm;
    try {
      indiaConfirm = decodeddata['TT']['total']['confirmed'];
      return indiaConfirm.toString();
    } catch (e) {
      return '';
    }
  }

  get getDeltaIndiaConfirm {
    int indiaDeltaConfirm;
    try {
      indiaDeltaConfirm = decodeddata['TT']['delta']['confirmed'];
      if(indiaDeltaConfirm != null)
      return indiaDeltaConfirm.toString();
      else return '';
    } catch (e) {
      return '';
    }
  }

  get getIndiaRecovered {
    int indiaRecovered;
    try {
      indiaRecovered = decodeddata['TT']['total']['recovered'];
      return indiaRecovered.toString();
    } catch (e) {
      return '';
    }
  }

  get getDeltaIndiaRecovered {
    int indiaDeltaReovered;
    try {
      indiaDeltaReovered = decodeddata['TT']['delta']['recovered'];
      if(indiaDeltaReovered != null)
      return indiaDeltaReovered.toString();
      else return '';
    } catch (e) {
      return '';
    }
  }

  get getIndiaDeceased {
    int indiaDeceased;
    try {
      indiaDeceased = decodeddata['TT']['total']['deceased'];
      return indiaDeceased.toString();
    } catch (e) {
      return '';
    }
  }

  get getDetaIndiaDeceased {
    int indiaDeltaDeceased;
    try {
      indiaDeltaDeceased = decodeddata['TT']['delta']['deceased'];
      if(indiaDeltaDeceased != null)
      return indiaDeltaDeceased.toString();
      else return '';
    } catch (e) {
      return '';
    }
  }

  get getIndiatested {
    int indiaTested;
    try {
      indiaTested = decodeddata['TT']['total']['tested'];
      int temp = (indiaTested /10000000).toInt();
      int temp1 = ((indiaTested%10000000)/100000).toInt();
      return temp.toString() + ' crore ' + temp1.toString() + ' lakh';
    } catch (e) {
      return '';
    }
  }

  get getDeltaIndiaTested {
    int indiaDeltaTested;
    try {
      indiaDeltaTested = decodeddata['TT']['delta']['tested'];
      if (indiaDeltaTested != null)
        return indiaDeltaTested.toString();
      else
        return '';
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
      return indiaActive.toString();
    } catch (e) {
      return '';
    }
  }

  get getStateConfirm {
    int stateConfirm;
    try {
      stateConfirm = decodeddata[myStateAcronym]['total']['confirmed'];
      return stateConfirm.toString();
    } catch (e) {
      print(e);
      return '';
    }
  }

  get getDeltaStateConfirm {
    int stateDeltaConfirm;
    try {
      stateDeltaConfirm = decodeddata[myStateAcronym]['delta']['confirmed'];
      if(stateDeltaConfirm != null)
      return stateDeltaConfirm.toString();
      else return '';
    } catch (e) {
      return '';
    }
  }

  get getstateRecovered {
    int stateRecovered;
    try {
      stateRecovered = decodeddata[myStateAcronym]['total']['recovered'];
      return stateRecovered.toString();
    } catch (e) {
      return '';
    }
  }

  get getDeltaStateRecovered {
    int stateDeltaReovered;
    try {
      stateDeltaReovered = decodeddata[myStateAcronym]['delta']['recovered'];
      if(stateDeltaReovered != null)
      return stateDeltaReovered.toString();
      else return '';
    } catch (e) {
      return '';
    }
  }

  get getStateDeceased {
    int stateDeceased;
    try {
      stateDeceased = decodeddata[myStateAcronym]['total']['deceased'];
      return stateDeceased.toString();
    } catch (e) {
      return '';
    }
  }

  get getDeltaStatedeceased {
    int stateDeltaDeceased;
    try {
      stateDeltaDeceased = decodeddata[myStateAcronym]['delta']['deceased'];
      if(stateDeltaDeceased != null)
      return stateDeltaDeceased.toString();
      else return '';
    } catch (e) {
      return '';
    }
  }

  get getStateTested {
    int stateTested;
    try {
      stateTested = decodeddata[myStateAcronym]['total']['tested'];
      return stateTested.toString();
    } catch (e) {
      return '';
    }
  }

  get getDeltaStateTested {
    int stateDeltaTested;
    try {
      stateDeltaTested = decodeddata[myStateAcronym]['delta']['tested'];
      if(stateDeltaTested != null)
      return stateDeltaTested.toString();
      else return '';
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
      return stateActive.toString();
    } catch (e) {
      return '';
    }
  }

  get getDistrictConfirm {
    int districtConfirm ;
    try {
      districtConfirm = decodeddata[myStateAcronym]['districts'][myDistrict]
          ['total']['confirmed'];
      return districtConfirm.toString();
    } catch (e) {
      print(e);
      return '';
    }
  }

  get getDeltaDistrictConfirm {
    int districtDeltaConfirm;
    try {
      districtDeltaConfirm = decodeddata[myStateAcronym]['districts']
          [myDistrict]['delta']['confirmed'];
      return districtDeltaConfirm.toString();
    } catch (e) {
      return '';
    }
  }

  get getDistrictRecovered {
    int districtRecovered;
    try {
      districtRecovered = decodeddata[myStateAcronym]['districts'][myDistrict]
          ['total']['recovered'];
      return districtRecovered.toString();
    } catch (e) {
      return '';
    }
  }

  get getDeltaDistrictRecovered {
    int districtDeltaReovered;
    try {
      districtDeltaReovered = decodeddata[myStateAcronym]['districts']
          [myDistrict]['delta']['recovered'];
          if(districtDeltaReovered != null)
      return districtDeltaReovered.toString();
      return '';
    } catch (e) {
      return '';
    }
  }

  get getDistrictDeceased {
    int districtDeceased;
    try {
      districtDeceased = decodeddata[myStateAcronym]['districts'][myDistrict]
          ['total']['deceased'];
      if (districtDeceased != null)
        return districtDeceased.toString();
      else
        return '';
    } catch (e) {
      return '';
    }
  }

  get getDeltaDistrictDeceased {
    int districtDeltaDeceased;
    try {
      districtDeltaDeceased = decodeddata[myStateAcronym]['districts']
          [myDistrict]['delta']['deceased'];
      if (districtDeltaDeceased != null)
        return districtDeltaDeceased.toString();
      else
        return '';
    } catch (e) {
      return '';
    }
  }

  get getDistrictTested {
    int districtTested;
    try {
      districtTested = decodeddata[myStateAcronym]['districts'][myDistrict]
          ['total']['tested'];
      if (districtTested != null)
        return districtTested.toString();
      else
        return '';
    } catch (e) {
      return '';
    }
  }

  get getDeltaDistrictTested {
    int districtdDeltaTested;
    try {
      districtdDeltaTested = decodeddata[myStateAcronym]['districts']
          [myDistrict]['delta']['tested'];
      if (districtdDeltaTested != null)
        return districtdDeltaTested.toString();
      else
        return '';
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
      return districtActive.toString();
    } catch (e) {
      return '';
    }
  }
}
