import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants_and_widgets.dart';
import 'get_data.dart';

class StatePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
      String stateAcronym = Provider.of<Data>(context, listen:  true).getStateAcronym;

    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(Provider.of<Data>(context, listen: true).getState,
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
          totalData: Provider.of<Data>(context, listen: true).getStateConfirm,
          increaseInData: Provider.of<Data>(context,listen: true).getDeltaStateConfirm,
          backgroundColor: backgroundConfirmedCasesColor,
          mainTextColor: confirmedCasescolor,
          sideTextColor: increaseInConfirmedCasescolor,
        ),
        DataTile(
          type: 'Active',
          totalData: Provider.of<Data>(context, listen:  true).getStateActive,
          increaseInData: '',
          backgroundColor: backgroundActiveCasesColor,
          mainTextColor: activeCasesColor,
          sideTextColor: activeCasesColor,
          icon: null,
          ),
        DataTile(
          type: 'Recovered',
          totalData: Provider.of<Data>(context, listen: true).getstateRecovered,
          increaseInData: Provider.of<Data>(context, listen: true).getDeltaStateRecovered,
          backgroundColor: backgroundRecoverevColor,
          mainTextColor: recoveredColor,
          sideTextColor: increaseInRecoveryColor,
        ),
        DataTile(
          type: 'Deceased',
          totalData: Provider.of<Data>(context, listen: true).getStateDeceased,
          increaseInData: Provider.of<Data>(context, listen: true).getDeltaStatedeceased,
          backgroundColor: Colors.grey[300],
          mainTextColor: deseasedColor,
          sideTextColor: increaseInDeseasedColor,
        ),
        DataTile(
          type: 'Tested',
          totalData: Provider.of<Data>(context, listen: true).getStateTested,
          increaseInData: Provider.of<Data>(context, listen: true).getDeltaStateTested,
          backgroundColor: backgroundTestedColor,
          mainTextColor: testedColor,
          sideTextColor: increaseInTestedColor,
        ) ,
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
              Text(Provider.of<Data>(context, listen:  true).getRecoveryRate(stateAcronym) + '%',

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
              Text(Provider.of<Data>(context, listen:  true).getMortalityrate(stateAcronym)+'%',
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
              Text(Provider.of<Data>(context, listen:  true).getTestedRatio(stateAcronym)+'%',
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
       child: Text('WEAR MASKS!',textAlign: TextAlign.center,style: TextStyle(fontSize: 24,color: increaseInDeseasedColor),),
       
       ),
       SizedBox(height: 15,),
      ],
    );
  }
}