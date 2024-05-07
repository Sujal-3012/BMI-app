import 'package:flutter/material.dart';
import 'input_page.dart';

/*This project is based on customising widgets


FLUTTER THEMES -> it is simply a way for us to be able to define our custom color palette and our custom styling
for the look and feel for the app .So if you are creating app for a brand , company etc. , you can keep it
consistent across the screens and keep your own custom styling . You can read about themes in flutter docs under
the topic -> cookbook , The cookbook contains different recipes that demonstrate how to solve common problems while
writing flutter apps .

ThemeData WIDGET ->
In order to share a theme containing color and font styles across our entire app. We can provide ThemeData (to the
theme property of material app) to the material app constructor . if no theme is provided flutter creates a fallback
theme under the hood (default flutter light theme).

We will create an app theme for our app , to do this we need to provide ThemeData widget to the material app constructor
in its theme property , there are lots of properties inside ThemeData widget (check in docs), so that you can have some default
colors whenever you create a button or appbar and this is shared across all pages in your app .
You can use some basic themes available in ThemeData widget ex. theme: ThemeData.dark(); but for customisation ,you need
to create your very own theme .

VARIOUS PROPERTIES OF ThemeData widget->

* primaryColor - background color for major parts of the app. ex. toolbar , tab bars etc. This does not include the body of the
  scaffold .
  ThemeData accent properties - accentColor, accentColorBrightness, accentIconTheme, and accentTextTheme - were no longer used
  by the Material library. They had been replaced by dependencies on the theme’s colorScheme and textTheme properties as part of
  the long-term goal of making the default configurations of the material components depend almost exclusively on these two properties.

* scaffoldBackgroundColor - to only change the background color of scaffold in a material app .
* textColor - applies to all type of texts in our app .
* textTheme - when we want to change the color of only certain type of text in our app, we can specify the part of text that we want to
  change , is it button , is it caption or headline etc .
* copyWith() - not a property but used when you majorly want to use a already defined theme and just want to change a few properties . this will do it
               ThemeData.dark().copyWith(//do the changes here).
* Theme() - not a property , this class gives us more granular control over theme of widgets , for ex. you just want to change the theme of button then ,
  you can wrap the button inside Theme widget and it always ask for theme property which requires ThemeData .
* appBarTheme - to set the color or theme for the appBar .


COLORS ->
till now we have used colors from the material palette , by Colors.<shade> , to use any other color we need to use
hex code for that color , this can be done by online site color zilla which helps you pick the hex code of any color you see on web .
It is available in chrome and firefox only .
Now to use colors with hex code you need to use Color class with constructor -> Color(int value), in the place of value provide the hex
code . If you see Color class it is expecting a 32 bit  color value in ARGB format.

A - degree of transparency of color , for opaque it is 0xFF
now in '#0B1034' , 0B is for R , 10 for G , 34 for B. Whenever you copy the hex code it only includes the code for RGB but not of A ,
which decides opacity of color .  # signifies HEX code . By the combination of Red , Green and Blue we get a color . You can see on
stack overflow about how to use hex code to represent different values .
To use the hex code in dart simply delete the # sign and add 0xFF.


HOW FLUTTER APPS ARE GENERALLY STRUCTURED ->
In the main.dart file we have all the theming portion and for different screens we have different dart files . It makes
sense to take the widgets that are repeated in the widget tree and remove them so that we can consolidate and simply use
the widgets wherever we need to.

Now we have our custom widgets which are consolidated in their own files. So we can reuse them across our project .
ex. we use Text() widget but it is consolidated / defined in text.dart file , separately so can be used anywhere across the project .
*/
void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0B1034),
        //by doc we get scaffoldBackgroundColor , this is exactly what we want to change .
        scaffoldBackgroundColor: const Color(0xFF0B1034),
        appBarTheme: const AppBarTheme(color: Color(0xFF0B1034)),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          /* bodyText1 → TextStyle? Used for emphasizing text that would otherwise be bodyMedium. bodyText1 is deprecated */
        ),
      ),

      home:
          const InputPage(), //Input page as home page ,since it is a stateful widget so it can update.
    );
  }
}
