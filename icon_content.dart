import 'package:flutter/material.dart';
import 'constants.dart';
//this text style is given here so that , we do not have to search for it if we want to change it also this style can be used at various places now .

class ChildOfCard extends StatelessWidget {
  const ChildOfCard({
    super.key,
    required this.icon,
    required this.text,
  });
  final Icon icon;
  final String text;

  const ChildOfCard.custom({Key? k, required this.icon, required this.text})
      : super(key: k);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(height: 15.0),
        Text(
          text,
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}
