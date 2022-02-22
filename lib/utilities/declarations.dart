// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF303030);
const Color confirmColor = Colors.black;
const Color activeColor = Color(0xFF017BFF);
const Color recoveredColor = Color(0xFF29A746);
const Color deathsColor = Color(0xFFFF1242);

LinearGradient gradientShimmer = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  // ignore: prefer_const_literals_to_create_immutables
  colors: <Color>[
    Color(0xFFE0E0E0),
    Color(0xFFF5F5F5),
  ],
);