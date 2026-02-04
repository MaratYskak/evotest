import 'package:flutter/material.dart';

const Color kDateTextColor = Color(0xFFBCBCBF);
const Color kHeadlineTextColor = Color(0xFF4C4C69);

const TextStyle kDateTextStyle = TextStyle(
  fontFamily: 'Nunito',
  fontWeight: FontWeight.w700, // Bold
  fontSize: 18.0,
  height: 1.22,
  letterSpacing: 0.0,
  color: kDateTextColor,
);

const TextStyle kHeadlineTextStyle = TextStyle(
  fontFamily: 'Nunito',
  fontWeight: FontWeight.w800, // ExtraBold
  fontSize: 16.0,
  height: 1.375, // 22 / 16
  letterSpacing: 0.0,
  color: kHeadlineTextColor,
);

const TextStyle kTitleTextStyle = TextStyle(
  fontFamily: 'Nunito',
  fontWeight: FontWeight.w400, // Regular
  fontSize: 11.0,
  height: 1.0, // 100%
  letterSpacing: 0.0,
  color: kHeadlineTextColor,
);
