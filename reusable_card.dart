import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  //This is a custom widget -> container with some margin and bg color and rounded corner
  /*Our custom widget is similar to flutter widgets, ex.our Container has margin, color, decoration properties .These
  are all properties that are in that particular class .You can see by clicking on it that container is also a stateless
  widget having properties such as alignment , padding and decoration and we can specify them when we create a new container
  widget same as how our custom widget has been created .
  We are using this card for making every card on our screen , but every card will have different contents therefore we need
  to have a child property .*/
  const ReusableCard({
    // To keep the widget Stateless, you need to declare the properties as final and initialize them in the constructor.
    super.key,
    required this.c,
    this.cardChild,
    required this.onPress,
  });
  final Color c;
  /*if you don't make c as final then the class Name was showing an error as-> This class (or a class that this class
  inherits from) is marked as '@immutable', but one or more of its instance fields aren't final: ReusableCard.c) . */
  final VoidCallback?
      onPress; //We cannot make onPress of type Function(as done by Angela) due to null safety because onTap requires a void call back but you were trying to give it a Function .
  final Widget? cardChild; //? sign denotes that the child can be null .

  //non - default constructor
  const ReusableCard.ofColor(
      {Key? k, required this.c, this.cardChild, this.onPress})
      : super(key: k);
  /* a named argument with a non-nullable type must either have a default or be marked with the new required keyword.
  Otherwise, it would not make sense for it to be non-nullable, because it would default to null when not passed.*/

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /*in the previous code in input_page.dart you can see that the reusable card widgets are wrapped with the detector
      separately making it length so here it is made as a property of re usable card and it is expecting a fn , so we
      will also use - passing fns as object . */
      onTap:
          onPress, //I need to directly give onPress as i cannot use setState here as it is stateless widget, also onPress is of void callback as onTap accepts void callback only.
      //onTap can be null , we have used this property because sometimes we may not want our reusable card to detect gestures .
      //onPress is the fn that is going to be called when the g detector detects a tap .
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          //color is something that we need to change about our reusable cards, so make it a property of this class.
          color: c,
        ),
        child: cardChild,
      ),
    );
  }
}
