import 'package:flutter/material.dart';
import '../services/apicall_covid.dart';
import '../models/data_global.dart';
import 'statistics_global.dart';
import 'global_loading.dart';

ServiceCovid covidService = ServiceCovid();

class GlobalPage extends StatefulWidget {

  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {

  late Future<GlobalData> summary;

  @override
  void initState(){
    super.initState();
    summary = covidService.getGlobalData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Global COVID-19 Case Data",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              GestureDetector(
                onTap: (){
                  setState(() {
                    summary = covidService.getGlobalData();
                  });
                },
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              )
            ],
          ),
          ),

          FutureBuilder(
            future: summary,
            builder: (context, snapshot){
              if(snapshot.hasError){
                return Center(child: Text("Oops! Data could not be fetched! Please check your internet connection and try again!", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),);
              }
              switch(snapshot.connectionState){
                case ConnectionState.waiting: {
                  return LoadingWidgetGlobal();
                }
                default: {
                  return !snapshot.hasData
                  ? Center(child: Text("No data found!", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),)
                  : GlobalStatistics(summary: snapshot.data as GlobalData);
                }
              }
            },
          )
      ],
    );
  }
}