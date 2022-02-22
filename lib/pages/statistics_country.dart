import 'package:cov_tracker/models/time_series_cases.dart';
import 'package:cov_tracker/pages/charts.dart';
import 'package:flutter/material.dart';
import '../models/data_countries.dart';
import '../utilities/declarations.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CountryStatistics extends StatelessWidget {

  final List<CountryData> summaryList;

  CountryStatistics({required this.summaryList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildCard(
          "CONFIRMED", 
          summaryList[summaryList.length - 1].confirmed, 
          confirmColor, 
          "ACTIVE", 
          summaryList[summaryList.length - 1].active, 
          activeColor
        ),

        buildCardtwo(
          "DEATHS",
          summaryList[summaryList.length -1].death,
          deathsColor
        ),

        buildCardChart(summaryList),
      ],
    );
  }

  Widget buildCard(String leftTitle, int leftValue, Color leftColor, String rightTitle, int rightValue, Color rightColor){
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  leftTitle,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                Expanded(
                  child: Container(),
                ),
                
                Text(
                  "Total",
                  style: TextStyle(
                    color: leftColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),

                Text(
                  leftValue.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                  style: TextStyle(
                    color: leftColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  rightTitle,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                Expanded(
                  child: Container(),
                ),
                
                Text(
                  "Total",
                  style: TextStyle(
                    color: rightColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),

                Text(
                  rightValue.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                  style: TextStyle(
                    color: rightColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardtwo(String centerTitle, int centerValue, Color centerColor){
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  centerTitle,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                Expanded(
                  child: Container(),
                ),
                
                Text(
                  "Total",
                  style: TextStyle(
                    color: centerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),

                Text(
                  centerValue.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                  style: TextStyle(
                    color: centerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardChart(List<CountryData> summaryList){
    return Card(
      elevation: 1,
      child: Container(
        height: 190,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Chart(
          _createData(summaryList),
          animate: false,
        ),
      ),
    );
  }

  static List<charts.Series<TimeSeriesCases, DateTime>> _createData(List<CountryData> summaryList){

    List<TimeSeriesCases> confirmedData = [];
    List<TimeSeriesCases> activeData = [];
    List<TimeSeriesCases> deathsData = [];


    for(var item in summaryList){
      confirmedData.add(TimeSeriesCases(item.date, item.confirmed));
      activeData.add(TimeSeriesCases(item.date, item.active));
      deathsData.add(TimeSeriesCases(item.date, item.death));
    }

    return [
      // ignore: unnecessary_new
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Confirmed',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(confirmColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: confirmedData,
      ),

      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Active',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(activeColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: activeData,
      ),

      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Deaths',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(deathsColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: deathsData,
      ),
    ];

  }
}