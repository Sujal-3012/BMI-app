import 'package:flutter/material.dart';

//Why all constants are starting from k? This is due to naming convention, k represents constant
//Also when you type k , android studio is relevant enough to show you all the relevant constants at that time
//It will also show constants that flutter has designed , by it gets much easier to search constants after this list gets much longer
const kBottomContainerHeight = 80.0;
const kActiveCardColor =
    Color(0xFF1D1E33); //because this is used many times in our app .
const kInactiveCardColor = Color(
    0xFF111328); //little bit darker than the active card color . When the card gets selected , it's color changes to activeCardColor.
const kBottomContainerColor = Color(0xFFEB1555);
const TextStyle kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF8D8E98),
);
const kNumberTextStyle = TextStyle(
  fontSize: 60.0,
  fontWeight: FontWeight.w900,
);
const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const kTitleTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);

const kResultTextStyle = TextStyle(
  color: Color(0xFF24D876),
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const kBMITextStyle = TextStyle(
  fontSize: 100.0,
  fontWeight: FontWeight.bold,
);

const kBodyTextStyle = TextStyle(
  fontSize: 22.0,
);
