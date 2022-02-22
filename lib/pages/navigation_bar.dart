import 'package:flutter/material.dart';
import '../utilities/declarations.dart';



class NavBar extends StatelessWidget {
  
  final String header;
  final bool chosen;
  final Function() onChosen;

  NavBar({required this.header, required this.chosen, required this.onChosen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onChosen();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Text(
            header,
            style: TextStyle(
              color: chosen ? primaryColor : Colors.grey[400],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          chosen
          ? Column(
            children: <Widget>[
              const SizedBox(
                height: 12,
              ),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              ),

            ],
          )
          : Container()

        ],
      ),
    );
  }
}