
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants_and_widgets.dart';
import 'get_data.dart';

class DistrictPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(Provider.of<Data>(context, listen: true).getDistrict,
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
          totalData: Provider.of<Data>(context, listen: true).getDistrictData(totalOrDelta: 'total', type: 'confirmed'),
          increaseInData: Provider.of<Data>(context, listen: true).getDistrictData(totalOrDelta: 'delta', type: 'confirmed'),
          backgroundColor: backgroundConfirmedCasesColor,
          mainTextColor: confirmedCasescolor,
          sideTextColor: increaseInConfirmedCasescolor,
        ),
        DataTile(
          type: 'Active',
          totalData: Provider.of<Data>(context, listen: true).getDistrictActive,
          increaseInData: '',
          backgroundColor: backgroundActiveCasesColor,
          mainTextColor: activeCasesColor,
          sideTextColor: activeCasesColor,
          icon: null,
          ),
        DataTile(
          type: 'Recovered',
          totalData: Provider.of<Data>(context, listen: true).getDistrictData(totalOrDelta: 'total', type: 'recovered'),
          increaseInData: Provider.of<Data>(context, listen: true).getDistrictData(totalOrDelta: 'delta', type: 'recovered'),
          backgroundColor: backgroundRecoverevColor,
          mainTextColor: recoveredColor,
          sideTextColor: increaseInRecoveryColor,
        ),
        DataTile(
          type: 'Deceased',
          totalData: Provider.of<Data>(context, listen: true).getDistrictData(totalOrDelta: 'total', type: 'deceased'),
          increaseInData: Provider.of<Data>(context, listen: true).getDistrictData(totalOrDelta: 'delta', type: 'deceased'),
          backgroundColor: Colors.grey[300],
          mainTextColor: deseasedColor,
          sideTextColor: increaseInDeseasedColor,
        ),
        DataTile(
          type: 'Tested',
          totalData: Provider.of<Data>(context, listen: true).getDistrictData(totalOrDelta: 'total', type: 'tested'),
          increaseInData: Provider.of<Data>(context, listen: true).getDistrictData(totalOrDelta: 'delta', type: 'tested'),
          backgroundColor: backgroundTestedColor,
          mainTextColor: testedColor,
          sideTextColor: increaseInTestedColor,
        )  ,
        Padding(
         padding: const EdgeInsets.all(8.0),
         child: Row(
           children: <Widget>[
             Text('Recovery Rate: ',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: primaryColor
                ),),
              Text(Provider.of<Data>(context, listen: true).getDistrictRecoveryRate,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: recoveredColor
                ),),  
           ],
         ),
       ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Row(
           children: <Widget>[
             Text('Mortality Rate: ',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: primaryColor
                ),),
              Text(Provider.of<Data>(context, listen: true).getDistrictMortalityRate,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: confirmedCasescolor
                ),),  
           ],
         ),
       ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Row(
           children: <Widget>[
             Text('Confirmed/Tested: ',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: primaryColor
                ),),
              Text(Provider.of<Data>(context, listen: true).getDistrictTestRatio,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: testedColor
                ),),  
           ],
         ),
       ),
       SizedBox(height: 15,),
       Container(height: 25,
       child: Text('PLEASE WEAR MASKS!',textAlign: TextAlign.center,style: TextStyle(fontSize: 24,color: increaseInDeseasedColor),),
       
       ),
       SizedBox(height: 15,),
      ],
    );
  }
}