import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryLoadingPage extends StatelessWidget {
  final bool inputTextLoading;

  CountryLoadingPage({required this.inputTextLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        inputTextLoading ? loadingInputCard() : Container(),
        loadingCard(),
        loadingCard(),
        loadingChartCard()
      ],
    );
  }

  Widget loadingInputCard(){
    return Card(
      elevation: 1,
      child: Container(
        height: 105,
        padding: EdgeInsets.all(24),
        child: Shimmer.fromColors(  
          baseColor: Color(0xFFE0E0E0), 
          highlightColor: Color(0xFFF5F5F5),
          child: Container(
            width: double.infinity,
            height: 57,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget loadingCard(){
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Shimmer.fromColors(
          baseColor: Color(0xFFE0E0E0), 
          highlightColor: Color(0xFFF5F5F5),
          child: Column(
            children: <Widget>[
              Container(
                width: 100,
                height: 20,
                color: Colors.white,
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 30,
                color: Colors.white,
              ),
            ],
          ), 
        ),
      ),
    );
  }

  Widget loadingChartCard(){
    return Card(
      elevation: 1,
      child: Container(
        height: 180,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Shimmer.fromColors(
          baseColor: Color(0xFFE0E0E0), 
          highlightColor: Color(0xFFF5F5F5),
          child: Expanded(
            child: Container(
              color: Colors.white,
            ),
          ), 
        ),
      ),
    );
  }

}