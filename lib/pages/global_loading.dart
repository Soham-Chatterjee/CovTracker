import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class LoadingWidgetGlobal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        loadingCard(),
        loadingCard(),
        loadingCard(),
        loadingLabel()
      ],
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
                child:Container(),
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


  Widget loadingLabel(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Color(0xFF616161),
        highlightColor: Color(0xFF424242),
        child: Column(
          children: <Widget>[
            Container(
              width: 200,
              height: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

}