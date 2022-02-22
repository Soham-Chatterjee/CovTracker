import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/data_global.dart';
import '../models/data_countries.dart';
import '../models/countries.dart';

class ServiceCovid{

  Future<GlobalData> getGlobalData() async{
    final data = await http.Client().get(Uri.parse("https://api.covid19api.com/summary"));

    if (data.statusCode != 200){
      throw Exception();
    }
    GlobalData summary = new GlobalData.fromJson(json.decode(data.body));

    return summary;
  }


  Future<List<CountryData>> getCountryData(String slug) async{
    final data = await http.Client().get(Uri.parse("https://api.covid19api.com/total/dayone/country/" + slug));

    if (data.statusCode != 200){
      throw Exception();
    }

    List<CountryData> summaryList = (json.decode(data.body) as List).map((item) => new CountryData.fromJson(item)).toList();

    if(summaryList.length != 0){
      return summaryList;
    }
    else{
      return 'No data found' as List<CountryData>;
    }
  }

  Future<List<Countries>> getCountryList() async{
      final data = await http.Client().get(Uri.parse("https://api.covid19api.com/countries"));
      
      if(data.statusCode != 200)
        throw Exception();

      List<Countries> countries = (json.decode(data.body) as List).map((item) => new Countries.fromJson(item)).toList();
      
      return countries;
    }

}