import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  //We can customise it a lot as we are using such a basic building block
  //We can change a lot of its components, ex. shape, if we don't want its shape to be circle we can choose other shapes also
  //this is a stateless widget so we cannot use setState in its onPressed so we need it as argument while making object .
  const RoundIconButton({super.key, required this.icon, required this.onPress});
  final IconData icon;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      //to change the size see how FAB has been implemented , we see it is done by constraints
      constraints: const BoxConstraints.tightFor(
        width: 56,
        height: 56,
      ),
      shape: const CircleBorder(), //to keep it as a circle
      fillColor: const Color(0xFF4C4F5E), onPressed: onPress,
      elevation: 6,
      //until we specify the onPressed property , elevation property is in disabled state , you may instead use disablesElevation
      //elevation for when button is enabled but not pressed
      child: Icon(icon),
    );
  }
}
