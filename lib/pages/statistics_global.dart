// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../utilities/declarations.dart';
import '../models/data_global.dart';
import 'package:timeago/timeago.dart' as timeago;

class GlobalStatistics extends StatelessWidget {

  final GlobalData summary;

  GlobalStatistics({required this.summary});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildCard(
          "CONFIRMED CASES", 
          summary.updatedTotalConfirmed, 
          summary.updatedConfirmed, 
          confirmColor
        ),

        buildCard(
          "ACTIVE CASES", 
          summary.updatedTotalConfirmed - summary.updatedTotalRecoveries - summary.updatedTotalDeaths, 
          summary.updatedConfirmed - summary.updatedNewRecoveries - summary.updatedDeaths, 
          activeColor
        ),

        buildCard(
          "DEATHS", 
          summary.updatedTotalDeaths, 
          summary.updatedDeaths, 
          deathsColor
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Text(
            "Data updated " + timeago.format(summary.date),
            style: TextStyle(
              color: Colors.white,
              // fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        )
      ],
      
    );
  }

  Widget buildCard(String title, int totalCount, int todayCount, Color color){
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),

            Expanded(
              child: Container(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),

                    Text(
                      totalCount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                      style: TextStyle(
                        color: color,
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
                      "Today",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),

                    Text(
                      todayCount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                )
              ],
            )
          ]),
      ),
    );
  }
}