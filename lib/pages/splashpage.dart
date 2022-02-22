import 'package:flutter/material.dart';
import 'track.dart';
import '../utilities/declarations.dart';

class splashPage extends StatefulWidget {
  const splashPage({ Key? key }) : super(key: key);

  @override
  _splashPageState createState() => _splashPageState();
}

class _splashPageState extends State<splashPage> {

  @override
  void initState() {
    super.initState();
    pageForward();
  }

  pageForward() async{
    await (Future.delayed(Duration(milliseconds: 3000), () {}));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Tracker()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Text(
          'CovTracker',
          style: TextStyle(
            fontSize: 30, 
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}