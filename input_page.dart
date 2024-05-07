import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'reusable_card.dart';
import 'icon_content.dart';
import 'constants.dart';
import 'roundIconButton.dart';
import 'results_page.dart';
import 'bottomButton.dart';
import 'calculator_brain.dart';

//enums are declared outside classes
enum Gender {
  male,
  female,
}

//All changes here in constants will get reflected
/*To divide the screen we are going to use cards .

FOR ROUNDED CORNERS OF BOXES ->
we need to use decoration property which accepts a BoxDecoration widget , this widget has properties
such as color , image , border and also border radius .
NOTE -> When we use  container as :
body: Container(
          margin: const EdgeInsets.all(15),
          color: const Color(0xFF1D1E33),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          height: 200,
          width: 170,
      )

we get error - Cannot provide both a color and a decoration because color is actually a property of BoxDecoration widget
which is used to set the color of Container but to make it simple flutter team provided it as a property of Container also
but when you are using BoxDecoration then you must specify the color of container inside the BoxDecoration.

WHY ReusableCard CLASS ->
You see our container is used very much making our code look repetitive so when you want to use same widget many time what you
can do is to refactor that widget and maka a new class of it and use it wherever needed  by calling the constructor of it .
ADVANTAGE -> If you want to change something in these 5 containers , simply just change the ReusableCard class.


KEY CLASS ->
is used when you need to keep track of state of widgets , this is specially useful when your widgets are moving around in the
widget tree, when they are changing their position in the widget tree .This usually happens with animations. In most of the cases
we don't need it .You can see more detail on yt(Google developers) , Emily named instructor .

NAMED CONSTRUCTORS->
Use a named constructor to implement multiple constructors for a class or to provide extra clarity .Remember that constructors
are not inherited, which means that a superclass’s named constructor is not inherited by a subclass. If you want a subclass to
be created with a named constructor defined in the superclass, you must implement that constructor in the subclass.You can only
have one unnamed constructor, but you can have any number of additional named constructors . To make c non-nullable required is
mandatory .Read documentation of constructors .

DIFFERENCE BETWEEN @required keyword and required keyword ->
@required was used with older versions of dart now with null safety we use required keyword .
The @required annotation marks named arguments that must be passed; if not, the analyzer reports a hint.
With null safety, a named argument with a non-nullable type must either have a default or be marked with the new required keyword.
Otherwise, it would not make sense for it to be non-nullable, because it would default to null when not passed.

NON-NULLABLE -> Unless you explicitly tell Dart that a variable can be null, it's considered non-nullable. This default was chosen
after research found that non-null was by far the most common choice in APIs.

**********************************************************************************************************************************
LATE KEYWORD ->
Often, settable attributes also do not have initial values since they are expected to be set sometime later.
In such cases, you have two options:

1. Set it to an initial value. Often times, the omission of an initial value is by mistake rather than deliberate.
2. If you are sure that the attribute needs to be set before accessed, mark it as late.

WARNING: The late keyword adds a runtime check. If any user calls get before set they’ll get an error at runtime.
NOTE ->StatelessWidgets are marked as immutable elements within the widget tree. These elements expect the class level variables to
actually have an immutable value. This can be implemented with final or const keyword.In stateless wid. late is not used.
**********************************************************************************************************************************

**Why constant constructors with immutable classes ? ->PREFER declaring const constructors on @immutable classes.
If a class is immutable, it is usually a good idea to make its constructor a const constructor.
**********************************************************************************************************************************

FINAL VS. CONST ->
Note -> instance variable = instance field = property , all 3 are same .
Immutable -> Unchangeable
Every lego block(widgets by which we build our app) is immutable / stateless .But if this is the case then how do we make changes
to our app which is built up using whole bunch of immutable widgets , we can simply take one of the immutable widgets that needs to
be changed , destroy it and in its place add new which has the required changes . Stateless widgets are immutable and all of its
properties can only be set once , if you want to update it , create a new one with updates ,ex. Re Usable card, you have to create
a new one and pass a different color and create a new one . That's why we need to add the word final in each property of stateless
widget.

But final and const can both be immutable ->
ex. const int myConst = 2;
    final int myFinal = 4;

    myConst = 4;    //Error
    myFinal = 6;    //Error

    They can't be changed .

When to use final and const ? ->
* You can see documentation .
* final variable can only be set once whereas const is a compile time constant .
* In java final variables need to be assigned by user as jvm overlook them and do not give them default values . In java we also have static
  variables which are stored in method area at the time of class loading , even before compilation .

* When the code is compiled , it is converted to machine code, in that moment it has to be able to workout the value that should be held inside
  the constant , but for final it is not the case .final var can be worked out at any point down the line
  const int a = 2+5*8 , it is ok ,value will be calculated and saved in a .
  But I cannot use constant to store a value (thing) that is only available at that point of time in code ,say -I want to get the dimensions of
  a box on the screen . in this case I need to use a final . So a const cannot have access to anything at runtime. If something is created after
  the app is running, then it cannot be set to final.
  ex. const myConst = DateTime.now(); //error
  because DateTime.now() will be worked out after code has run
  final myFinal = DateTime.now();   //correct
**********************************************************************************************************************************

WHY THE COLOR PROPERTY OF RE USABLE CARD IS FINAL ?
it cannot be const because our color comes form when we create a new reusable card and that could be created any time not just at the time when
code is compiled  , it could be anytime when our app is running .

Now similarly it cannot be a simple variable (you may think that removed const , also remove final) because our ReUsable card is immutable . So whenever
we create a new re usable card then it will create an immutable stateless widget.
Whenever re usable card needs to change say it's color or size then that reusable card , that specific one actually gets destroyed and a new one takes
it's place . So it's properties can't be immutable , can't change ,that's why declared final.
**********************************************************************************************************************************

Whenever we are writing our code , the hard coded things are represented by constants in the code . Let's say we are creating the bottom part of our app
which is a container of fix height
**********************************************************************************************************************************
Since we will be using the same pattern to make children of our reusable cards , we are making a separate widget for it so that we can just invoke the
constructor and make the child of reusable card .
**********************************************************************************************************************************

key in constructors ->
Because you're using null-safe Dart and key can't be null because it has a non-nullable type Key. You're not doing anything wrong by making Key key
nullable. The super constructors that you're passing the key to accept the nullable type.
You can do like ->
const ChildOfCard.custom({Key? key, required this.i, required this.text}): super(key : key);
Actually here we are using initializer list ->
By default, a constructor in a subclass calls the superclass’s unnamed, no-argument constructor. The superclass’s constructor is called at the beginning
of the constructor body. If an initializer list is also being used, it executes before the superclass is called. In summary, the order of execution is as
follows:
1. initializer list
2. superclass’s no-arg constructor
3. main class’s no-arg constructor

**********************************************************************************************************************************
Final variables can only have one value and that is at the point where they are created .
**********************************************************************************************************************************
Since the ReusableCard and ChildOfCard were taking a lot of space ,hence they are moved to separate files . Also they are required in other
files also maybe when we create different screens or pages.
**********************************************************************************************************************************
MAKING ICON CARDS INTERACTIVE ->
Here we want the cards on our screen to respond on touch of user or when user presses it , so to add functionality of button , we can use TextButton, which
will give us that crucial onPressed property, but the problem with TextButton is that it affects our styling of the card , it's size , margins etc. , it is
kind of opinionated widget, ex. it has a default padding of 16.0 , hence here we will use GestureDetector widget .

GestureDetector Widget ->
GestureDetector is concerned with detecting gestures .A widget that detects gestures. Attempts to recognize gestures that correspond to its non-null callbacks.
If this widget has a child, it defers to that child for its sizing behavior. If it does not have a child, it grows to fit the parent instead. By default a
GestureDetector with an invisible child ignores touches; this behavior can be controlled with behavior. GestureDetector also listens for accessibility events
and maps them to the callbacks. To ignore accessibility events, set excludeFromSemantics to true.

It has many properties which can be set ex.
onTap       //same as onPressed of the TextButton
onDoubleTap
OnForcePress
onHorizontalDrag
and many more

* What we want -> when we click on cards say- male or female , we want it to change color , to show that it has been selected . Male and female
buttons will start from a dark background color and they will change their color to match other cards when they get tapped . This is to show that
which card is active


*********************************************************************** PREVIOUS CODE *************************************************************************
class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  /*In stateful widgets we can have variables which are not final , these variables are used to change the state of the cards .
  Initially both male and female cards are not selected so they will have inactive color and when tapped , their color will change
  to active color*/
  Color maleCardColor = inactiveCardColor;
  Color femaleCardColor = inactiveCardColor;

  //1 - male , 2 - female
  void updateColor(int gender) {
    if (gender == 1) {
      if (maleCardColor == inactiveCardColor) {
        maleCardColor = activeCardColor;
      } else {
        maleCardColor = inactiveCardColor;
      }
    } else {
      if (femaleCardColor == inactiveCardColor) {
        femaleCardColor = activeCardColor;
      } else {
        femaleCardColor = inactiveCardColor;
      }
    }
  }

  //ye mene khud implement kiya
  void bothNotSelected(int gender) {
    //gender represent which is selected
    //if male card has been selected
    if (gender == 1) {
      femaleCardColor = inactiveCardColor; //switch off the female card color
    } else {
      maleCardColor = inactiveCardColor; //switch off the male card color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      body: Column(
        //it is going to have 3 expanded widgets
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(
              //row is going to have 2 expanded widgets
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      //onTap requires a void callback , same as onPressed .
                      setState(() {
                        updateColor(1);
                        bothNotSelected(1);
                      });
                    },
                    child: ReusableCard.ofColor(
                      c: maleCardColor,
                      cardChild: const ChildOfCard(
                        icon: Icon(
                          FontAwesomeIcons.mars,
                          size: 80.0,
                        ),
                        text: 'MALE',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        updateColor(2);
                        bothNotSelected(2);
                      });
                    },
                    child: ReusableCard.ofColor(
                      c: femaleCardColor,
                      cardChild: const ChildOfCard(
                        icon: Icon(
                          FontAwesomeIcons.mercury,
                          size: 80.0,
                        ),
                        text: 'FEMALE',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: ReusableCard.ofColor(
              c: activeCardColor,
              //cardChild: ChildOfCard(icon: icon, text: text),
            ),
          ),
          const Expanded(
            child: Row(
              //row is going to have 2 expanded widgets
              children: [
                Expanded(
                  child: ReusableCard.ofColor(c: activeCardColor),
                ),
                Expanded(
                  child: ReusableCard.ofColor(c: activeCardColor),
                ),
              ],
            ),
          ),
          Container(
            color: bottomContainerColor,
            //we want margin only at the top .
            margin: const EdgeInsets.only(top: 10),
            //we want it to stretch across all the width
            width: double.infinity,
            //fix height
            height:
                bottomContainerHeight, //this is given value using constant because later if want to change the height then it will be hard to search for it , so making it constant and defining at the top ,makes editing way more easier as we can simply look at the top at our constants and simply change to
          )
        ],
      ),
    );
  }
}

In this previous code we can see that it is looking a lot more wordy . Mainly the functionality of GestureWidget is creating problem .  We are using number to
represent gender . Enums will be used for it .Enumeration means establishing number for .
Ex. we have 3 types of car suv,hatchback and convertible, and we are representing them by using numbers say 1,2 and 3 . Now these no.s don't inherently have any
meaning , we are assigning them meaning and remembering them down the line and trying to force people who work with us to follow this convention and it is difficult .
What if we can give them a word , ex. if we can say car is of type .convertible , .suv or .hatchback , it is easier .


***********************************************************************************************************************************************************************

ENUMS
Boolean can have only two states , on/off , when we want to have more states such as -> high , medium or low then we use enums . So when there many options to encode
and not want to rely on numbers and want to give each member name , then enums are used.
*Note -> You cannot create enum inside classes .

enum EnumName = {typeA , typeB , typeC}

use -> EnumName.typeA

**Naming convention for enums is same as of class , first capital and camel casing .


 How enum works ?
 Suppose you have a class ->

 Here car type is associated with a number , it is not very good practice .

 # WITHOUT ENUM
 Car{
  int carType;
  Car({this.carType});
 }
 ***********************************************************
 # WITH ENUM

 enum carStyle {
  SUV,
  coupe,
  hatchback,
  convertible
 }

 Car{
  carStyle carType;       //now here carType is of enum type .
  Car({this.carType});
 }

 INITIALISATION WITH ENUM ->
 Car myCar = Car(carType : carStyle.SUV);   //this makes more sense


 ***********************************************************

TERNARY OPERATORS ->
just a one line expression
Condition ? DoThisIfTrue : DoThisIfFalse

uses ->
1. To replace complex if-else blocks .
2. We can even use it as an expression as it is of one line only .ex.->

   void main(){
     int age = 12;
     bool canBuyAlcohol = age > 18 ? true : false;
   }

   This is something that we cannot do with if else.
**********************************************************************************************************************************

UPGRADING OUR REUSABLE CARD TO DETECT GESTURES ALSO ->

Since in the previous code we need to make our reusable card as a child of gesture detector widget two times causing repetition , therefore we
want to upgrade our reusable card to detect gestures also , for other reusable cards also we might want this functionality to be able to detect
touch , even if we are not using the gesture detection property we want to at least reduce the code . To implement this we will pass functions
as if they are any other objects .

** In dart functions are first order objects , means they have a type and can be passed around just like any other type and they can also be set
as the value of variable and constant

PASSING FUNCTIONS AS OBJECTS ->

int add(int a , int b){
  return a+b;
}

int mul(int a , int b){
  return a*b;
}

int resultAdd = add(5,8);
int resultMul = mul(5,8);

Here I need to call different fn each time I want to calculate something , what we can do here is ->

# Passing fn as object

int calculator(int a , int b , Function f){
  //3rd argument is expecting a fn
  return f(a,b);
}

now I can call as ->

int resultAdd = calculator(5,8,add);
int resultMul = calculator(5,8,mul);

here I am calling the same fn each time .

** We can even assign function as a value of a variable .

Function calculator = (int a , int b , Function f){
  return f(a,b);
}

now my fn is stored inside a variable called calculator . It can also be made final which means I am no longer able to change assignment of my variable.
You can have fn in dart which are outside any class and even outside main fn , means we can have top level fns .

Ex. try copying to dartpad.dartlang to run

class Car{
  late Function drive;
  Car({required this.drive});
}

void slowDrive(){
  print("Driving slowly");
}

void fastDrive(){
  print("Driving slowly");
}

void main(){
  Car c = Car(drive : slowDrive); //notice there are no parenthesis on slowDrive
  print (c.drive);
}

Output -> Closure 'slowDrive'
It shows that the drive fn is associated with slowDrive() fn .It is saying that for
myCar object drive property is equal to slowDrive .


# drive fn will only trigger when I will use parenthesis.
  like c.drive()

  output -> Driving slowly

I can also update my car ->
myCar.drive = fastDrive;

** NOTE -> when I am passing fns I am only using the name of the fn but when I actually need to trigger the
   then I need to use the parenthesis .

We need to use this concept to in our re usable card , we need pass the gesture detector widget a fn to one of the property of our reusable card .
After implementation of this concept gesture detector will live in the re usable card class .

***************************************************************************************************************************************************

MAKING SEPARATE CONSTANTS FILE ->
what is the need to create a separate dedicated constants file ? On my first screen in the reusable card for height , I want to have the same text
styling as I had in male and female cards but that text style is defined as constant in icon_content file , so it would get really messy to import
that file here in input_page.dart and then to use it , so here the need for a separate file of constants arises .This file will hold the things that
are constant across our app , because we may want to use them at different places in our app .
Move all the constants to constants.dart file .

***************************************************************************************************************************************************

SETTING CROSS AXIS ALIGNMENT TO BASELINE ->

Above line is used to bring the height no. and unit that is cm to the same baseline . So that it looks like unit .
textBaseline is required if you specify the crossAxisAlignment with CrossAxisAlignment.baseline , otherwise you will
get error . it is required so that they know which baseline to align against .

textBaseLine is of 2 types ->

* alphabetic - for numbers or words
* ideographic - for graphical characters

***************************************************************************************************************************************************

SLIDER WIDGET ->

used to implement material design slider . Properties ->

* value - displayed as the value of the slider
* onChanged - expects a method (double as input and void as output)
              called during a drag when the user is selecting a new value for the slider by dragging.
              slider will pass the new value to the callback and we will be able to tap into that new
              value inside that anonymous function .

* onChangeStart - when user start dragging
* onChangeEnd - when user ends dragging
  and many more. # Read documentation .

parameters onChanged and value are required / mandatory .

Note - Slider passes the new value to the call back but does not actually change state / slide until the parent widget rebuilds the slider with the new value
       means call back should update the state of parent .



CUSTOMISING SLIDER WIDGET -> Lec 131.
we want the holder of handle of our slider widget to be a bit larger and also want to customise handle's color  .
The holder color is of same color as of the active track . There is no way to just change the color of the holder .
In slider class we have usual properties , but there is nothing to just change the size of that handle or color of
that handle . So there is another way to change the style of widget by using themes.

From Docs ->
To determine how it should be displayed (e.g. colors, thumb shape, etc.), a slider uses the SliderThemeData available
from either a SliderTheme widget or the ThemeData.sliderTheme a Theme widget above it in the widget tree. You can also
override some of the colors with the activeColor and inactiveColor properties, although more fine-grained control of
the look is achieved using a SliderThemeData.

We have set a theme for the whole app but we also said that we can have specific themes just for the individual
components of the app .We can do this by embedding widgets inside other widgets , in this case we could embed it
inside the slider theme widget . SliderTheme has a property called data , which expects SliderThemeData object which
has many things that we can set or change accordingly .

But disadvantage with this is you have to provide the value for each property of the SliderThemeData object .

Solution to this problem -> If you don't want to provide value for a whole lot of things and just want to tweak some
properties then we can use SliderThemeData.of() , in which we can provide build context , context is the current
state of our app , how our app appears as it is .

* .of() -> returns the data from the closest instance that encloses the given context .
* SliderThemeData.of() ->current state of app includes the current Theme , in which we have not performed any changes and
  if we say .of() , we get a copy of what it looks like by default , as it is .And then we can write .copyWith() , indie this
  copyWith we will only provide the changes about the sliderTheme .


NOTE -> Any design is possible either you design a custom widget that combines different flutter widgets or if you are using
material components , we can tap into themes to be able to customise it further , if you want to get more control over it .

***************************************************************************************************************************************************

COMPOSITION VS INHERITANCE -> LEC 132

In native android/ios development in java or swift , for more customisation what we do is we would inherit a component such
as slider and then we would override some of the properties or methods of those components . But in flutter we use composition
over inheritance , it means we want to build from the simplest widget possible , from scratch . That way flutter can see the
performance and make our app fast .

How composition is done ?
Even if we think of a simple widget say container it is made by - limited box , constrained box , align , padding and decorated box ,
these all are simple widget but by their combination we are able to make more complex widgets.

So rather than taking a pre build large widget such as floating action button and trying to inherit it and override it , it is much
easier to just break it down into small pieces to see how it is created by looking at the open source code and just building it
together by yourself using the basic building block .

NOTE -> By this concept we are making the last two reusable cards .

PROBLEM WITH FLOATING ACTION BUTTONS ->
The documentation clearly says that use at most one FAB at a time , it is not something that the documentation recommend but also
if you want to customise the widget then also we would not use FAB .

So far we have been using flutter components , we either tried to combine them together in different ways in our own custom widgets or
we have been digging deep into the theme and updating it to have a design that we have in our mind . Now we will dig into the code of
each of these widgets , this is possible due to open source nature of flutter .We can see whole source code of any widget. But we cannot
do that with ios ,ex. we cannot see how an ios button has been implemented .
We can see that a FAB is made from Raw material button , that is made from inkWell , which detect taps and if we don't want our custom
button to detect taps then we can remove it and can only have Material . Depending on how deep you want to go , we can design as custom
a design or component as we need .And we need not depend on default flutter components .

***************************************************************************************************************************************************

BUILDING FLUTTER WIDGETS FROM SCRATCH ->

So We will create our own RawMaterialButton to use

# For reference is the code in which we were using 2 FABs to make our last row of re usable cards having weight and age

const Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    FloatingActionButton(
      //FAB will get the color from theme if you are not explicitly specifying it
      backgroundColor: Color(0xFF4C4F5E),
      onPressed: null,
      child: Icon(
        Icons.add,
        color: Colors.white, //to set icon color
      ),
    ),
    SizedBox(width: 10),
    FloatingActionButton(
      backgroundColor: Color(0xFF4C4F5E),
      onPressed: null,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    ),
  ],
)

Now instead of it we are using our custom button -> RoundIconButton .

MULTI SCREEN APPS USING ROUTES AND NAVIGATION ->

In flutter screens and pages are called routes . Whenever we are talking about routes , think it as a way of getting to a screen or page.
To move to different routes we need to follow different paths ,if I want to go to screen 1 then I would trigger the screen 1 route .
In this case we need a flutter navigator that takes you to each of these routes to see each of these screens . For navigation to multiple
pages see screen_switching_demo.dart

***************************************************************************************************************************************************

DART MAPS ->
Collection types having key-value pairs , unlike lists they are not sorted .
Key maps to value .ex. ->

            {
Amy : 123,
James : 456,
tim : 012,
}

CREATION -> Map<KeyType , ValueType> mapName{
  key : value
}
here we can specify the datatype of key type and value type , I can also leave it to the dart to figure out the datatype of key and value but it is
recommended to specify using angular brackets .

USAGE ->
  mapName[key]

ex. from dartpad ->
Map<String , int> phoneBook = {
  'Sujal' : 9289644575,
  'Shruti' : 9289258876,
};

void main(){
  print(phoneBook['Sujal']);
}

output ->
9289644580

If you try to get value of a key that does not exist then it will give null .
# We can use this [] format to add values to the map .

void main(){
  phoneBook['Abhinav'] = 99876785;
}

Main advantage of map is that it is unordered .
Other methods are ->
.length - to get length
.keys = to print all the keys in a list
.values = to print all the values in a list

Ex

void main(){
  print(phoneBook.keys);
}

output -> (Sujal, Shruti)


***************************************************************************************************************************************************
 Earlier we had specific Bottom button saying Calculate but we required a same button on the second screen also so I made this as a
 Widget (Custom) , having different onTap and text properties , so that this widget can be used to create both the Calculate and Re-calculate
 button .

GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const ResultsPage();
          //You will notice that our theme is also carried to the second page
        },
      ),
    );
  },
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
    child: const Center(
      child: Text(
        'CALCULATE',
        style: kLargeButtonTextStyle,
      ),
    ),
  ),
)





***************************************************************************************************************************************************

THIS input_page.dart IS NOW DEDICATED TO THE USER INTERFACE AND THE FUNCTIONALITY OF THE INPUTS SCREEN IN OUR APP .
TO MAKE YOUR lib FOLDER ARRANGED YOU CAN MAKE A NEW DIRECTORY AND THE MOVE THE COMPONENTS THERE .ALL YOU NEED FOR
THIS IS TO JUST CHANGE THE PATH FOR IMPORT AS THE dart FILES MOVED TO A NEW LEVEL .

NOTE -> FOR THE ACTUAL FUNCTIONALITY CHECK THE bmi_brain.dart file .


 */

//In the new code we have implemented enums and ternary operators to make the code shorter .
//because we don't need so much of code just for toggling the color of card .
//In documentation an arrow represent that the property is expecting a function .
//Note -> We can leave onPressed as it is without any value .

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  /*In stateful widgets we can have variables which are not final , these variables are used to change the state of the cards .
  Initially both male and female cards are not selected so they will have inactive color and when tapped , their color will change
  to active color*/
  Gender?
      gender; //when the app starts gender is null .After tapping button gender will change

  int height =
      180; //This cannot be constant as it is going to change frequently .
  int weight = 50;
  int age = 18;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      body: Column(
        //it is going to have 3 expanded widgets
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              //row is going to have 2 expanded widgets
              children: [
                Expanded(
                  child: ReusableCard.ofColor(
                    //onPress is mada a property of re usable cards to add gesture detection , it may not be used if you don't want your card to detect gestures
                    onPress: () {
                      setState(() {
                        gender = Gender.male;
                      });
                    },
                    c: gender == Gender.male
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    cardChild: const ChildOfCard(
                      icon: Icon(
                        FontAwesomeIcons.mars,
                        size: 80.0,
                      ),
                      text: 'MALE',
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard.ofColor(
                    onPress: () {
                      setState(() {
                        gender = Gender.female;
                      });
                    },
                    c: gender == Gender.female
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    cardChild: const ChildOfCard(
                      icon: Icon(
                        FontAwesomeIcons.mercury,
                        size: 80.0,
                      ),
                      text: 'FEMALE',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            /*containers size themselves to their child's size otherwise try to be as large as the parent allows .
            To correct this you can say in the properties of column , stretch the cross axis alignment , so that all
            the children of column stretches to full width of the column no matter what is the size of children .*/
            child: ReusableCard.ofColor(
              c: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'HEIGHT', //because Text requires a string
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline
                        .alphabetic, //this is added to make our cross axis alignment work
                    children: [
                      Text(
                        //this shows the height selected by user
                        height.toString(), //because Text requires a string
                        style: kNumberTextStyle,
                      ),
                      const Text(
                        'cm',
                        //this cm is going to have the same text style as in case of male and female .
                        style: kLabelTextStyle,
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: const SliderThemeData(
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape: RoundSliderOverlayShape(
                          overlayRadius:
                              24.0), //this adds a transparent ring around holder when touched
                      thumbColor: Color(0xFFEB1555),
                      //Color will not be reflected until you remove activeColor from slider because that is overriding it
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Color(0xFF8D8E98), //grey on right
                      overlayColor: Color(
                          0x29EB1555), //same as thumb color ,just a little bit lighter
                    ),
                    child: Slider(
                      value: height
                          .toDouble(), //because value is expecting a double
                      min: 120,
                      max: 220,
                      onChanged: (double newValue) {
                        //newValue will be passed to us from the slider when the slider gets changed
                        setState(() {
                          //to make sure the state of our slider gets updated with the new height
                          height = newValue.toInt();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              //row is going to have 2 expanded widgets -> for weight and age
              children: [
                Expanded(
                  //WEIGHT
                  child: ReusableCard.ofColor(
                    c: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPress: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ), //we have not used Icons.add as it is not bold
                            const SizedBox(width: 10),
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPress: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  //AGE
                  child: ReusableCard.ofColor(
                    c: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPress: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ), //we have not used Icons.add as it is not bold
                            const SizedBox(width: 10),
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPress: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            onPress: () {
              CalculatorBrain calc =
                  CalculatorBrain(height: height, weight: weight);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ResultsPage(
                      resultText: calc.calculateBMI(),
                      bmiResult: calc.getResult(),
                      interpretation: calc.getInterpretation(),
                    );
                    //the above command is passing the calculated results to the second screen .
                    //You will notice that our theme is also carried to the second page
                  },
                ),
              );
            },
            text: 'CALCULATE',
          ),
        ],
      ),
    );
  }
}
