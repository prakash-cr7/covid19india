import 'package:covid19india/district_search_screen.dart';
import 'package:covid19india/state_search_screen.dart';
import 'package:flutter/material.dart';
import 'country_page.dart';
import 'state_page.dart';
import 'district_page.dart';
import 'state_search_screen.dart';
import 'district_search_screen.dart';
import 'constants_and_widgets.dart';
import 'get_data.dart';
import 'package:provider/provider.dart';
import 'drawer.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

//  bool darkMode = false;
//  bool receiveNotification = false;

  static int selectedIndex = 0;
  PageController pageController = PageController(initialPage: selectedIndex);

  FloatingActionButton fab(int currentPageIndex) {
    if (currentPageIndex != 0) {
      return FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(
          Icons.search,
          color: Colors.white,
          size: 30,
          semanticLabel: 'Search',
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: currentPageIndex == 1
                          ? StateSearchPage()
                          : DistrictSearchPage(),
                    ),
                  ));
        },
      );
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        floatingActionButton: fab(selectedIndex),
        appBar: AppBar(
          title: Text(
            'COVID19INDIA',
            style: smallFontTextstyle,
          ),
          backgroundColor: primaryColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.my_location,
                color: Colors.white,
              ),
              onPressed: () {
                Provider.of<Data>(context, listen: false).updateLocation();
              },
            ),
            SizedBox(
              width: 15,
            ),
          ],
          centerTitle: true,
        ),
        drawer: DrawerScreen(),
        body: Provider.of<Data>(context, listen: true).prog ? Center(child: CircularProgressIndicator()) :
        PageView(
          children: <Widget>[CountryPage(), StatePage(), DistrictPage()],
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  'INDIA',
                  style: smallFontTextstyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.place),
                title: Text(
                  Provider.of<Data>(context, listen: true).getState,
                  style: smallFontTextstyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_city),
                title: Text(
                  Provider.of<Data>(context, listen: true).getDistrict,
                  style: smallFontTextstyle,
                )),
          ],
          backgroundColor: primaryColor,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
              pageController.animateToPage(selectedIndex,
                  duration: Duration(microseconds: 400), curve: Curves.bounceIn);
            });
          },
        ),
      ),
    );
  }
}

