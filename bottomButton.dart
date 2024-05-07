import 'package:flutter/material.dart';
import 'constants.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.onPress,
    required this.text,
  });

  final VoidCallback onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        color: kBottomContainerColor,
        //we want margin only at the top .
        margin: const EdgeInsets.only(top: 10),
        //we want it to stretch across all the width
        width: double.infinity,
        //fix height
        height: kBottomContainerHeight,
        //this is given value using constant because later if want to change the height then it will be hard to search for it , so making it constant and defining at the top ,makes editing way more easier as we can simply look at the top at our constants and simply change them.
        padding: const EdgeInsets.only(
            bottom: 20.0), //as the text was going too down .
        child: Center(
          child: Text(
            text,
            style: kLargeButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
