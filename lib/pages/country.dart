import 'package:cov_tracker/pages/country_loading.dart';
import 'package:flutter/material.dart';
import '../services/apicall_covid.dart';
import '../models/countries.dart';
import '../models/data_countries.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'statistics_country.dart';

ServiceCovid covidService = ServiceCovid();

class CountryPage extends StatefulWidget {

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {

  final TextEditingController _typeAheadController = TextEditingController();

  late Future<List<Countries>> countryList;
  late Future<List<CountryData>> summaryList;

  @override
  void initState() {
    super.initState();
    countryList = covidService.getCountryList();
    summaryList = covidService.getCountryData("india");

    this._typeAheadController.text = "India";
  }

  List<String> _getSuggestions(List<Countries> list, String query){
    List<String> matches = [];

    for (var item in list){
      matches.add(item.country);
    }

    matches.retainWhere((element) => element.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Countries>>(
      future: countryList,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Center(
                  child: Text(
                          "Oops! Data could not be fetched! Please check your internet connection!", 
                          style: TextStyle(
                                  color: Colors.white
                                 ), 
                          textAlign: TextAlign.center,
                         ),
                 );
        }
        switch (snapshot.connectionState){
          case ConnectionState.waiting:{
            return CountryLoadingPage(
              inputTextLoading: true,
            );
          }
          default:{
            return !snapshot.hasData
            ? Center(child: Text("No data found!", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),)
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  child: Text(
                    "Country Wise COVID-19 case details ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),

                TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _typeAheadController,
                    decoration: InputDecoration(
                      hintText: "Type the country name",
                      hintStyle: TextStyle(fontSize: 16,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Color(0xFFEEEEEE),
                      contentPadding: EdgeInsets.all(20),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 24, right: 16),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern){
                    return _getSuggestions(snapshot.data as List<Countries>, pattern);
                  },
                  itemBuilder: (context, suggestion){
                    return ListTile(
                      title: Text(suggestion as String),
                    );
                  },
                  transitionBuilder: (context, suggestionsBox, controller){
                    return suggestionsBox;
                  },
                  onSuggestionSelected: (suggestion){
                    this._typeAheadController.text = suggestion as String;
                    setState(() {
                      summaryList = covidService.getCountryData(snapshot.data!.firstWhere((element) => element.country == suggestion).slug);
                    });
                  },
                ),

                SizedBox(
                  height: 8,
                ),

                FutureBuilder(
                  future: summaryList,
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return Center(child: Text("Oops! Data could not be fetched or isn't available. Please check your internet connection or try any other keyword", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),);
                    }
                    switch (snapshot.connectionState){
                      case ConnectionState.waiting:{
                        return CountryLoadingPage(
                          inputTextLoading: false,
                        );
                      }
                      default:{
                      return !snapshot.hasData
                      ? Center(child: Text("Empty"),)
                      : CountryStatistics(
                        summaryList: snapshot.data as List<CountryData>,
                      );
                      }
                    }
                    
                  },
                )
              ],
            );
          }
        }
      },
    );
  }
}