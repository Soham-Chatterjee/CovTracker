import 'package:cov_tracker/pages/country.dart';
import 'package:cov_tracker/pages/global.dart';
import 'package:flutter/material.dart';
import '../utilities/declarations.dart';
import 'navigation_bar.dart';
import 'country.dart';
import 'global.dart';

enum NavigationStatus {
  GLOBAL,
  COUNTRY,
}

class Tracker extends StatefulWidget {
  const Tracker({ Key? key }) : super(key: key);

  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  NavigationStatus navigationStatus = NavigationStatus.GLOBAL;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Center(
          child: Text(
            "COVID-19 Data Tracker Live"
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: navigationStatus == NavigationStatus.GLOBAL ? GlobalPage() : CountryPage(),
              ),
            ),
          ),

          Container(
            height: size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget> [
                NavBar(
                  header: 'Global', 
                  chosen: navigationStatus == NavigationStatus.GLOBAL, 
                  onChosen: (){
                    setState(() {
                      navigationStatus = NavigationStatus.GLOBAL;
                    });
                  }
                ),

                NavBar(
                  header: 'Country', 
                  chosen: navigationStatus == NavigationStatus.COUNTRY, 
                  onChosen: (){
                    setState(() {
                      navigationStatus = NavigationStatus.COUNTRY;
                    });
                  }
                ),
                
              ],
            ),
          ),


        ],
      ),
    );
  }
}