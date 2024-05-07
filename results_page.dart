import 'package:bmi_claculator/constants.dart';
import 'package:flutter/material.dart';
import 'reusable_card.dart';
import 'bottomButton.dart';

/*Here we don't have any access to properties , these will be coming from the input page .
So we need to create some properties here in order for us to be able to pass the data to this file.

bmiResult
resultText
interpretation

These 3 properties , we will be receiving from the input_page through constructor initialisation , when we
call the constructor of result_page , in the Navigator.push .
 */

class ResultsPage extends StatelessWidget {
  const ResultsPage(
      {super.key,
      required this.bmiResult,
      required this.resultText,
      required this.interpretation});

  final String bmiResult;
  final String resultText;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              //alignment: Alignment.bottomLeft,
              child: const Center(
                child: Text(
                  'Your Result',
                  style: kTitleTextStyle,
                ),
              ),
            ),
          ),
          Expanded(
            //I want this container to be quite large as compared to the upper container
            flex: 5,
            child: ReusableCard.ofColor(
              //this reusable card will not act as button so we will use our non default constructor so that only color is required
              c: kActiveCardColor,
              cardChild: Column(
                //Column inside Column
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    bmiResult.toUpperCase(),
                    style: kResultTextStyle,
                  ),
                  Text(
                    resultText,
                    style: kBMITextStyle,
                  ),
                  Text(
                    interpretation,
                    style: kBodyTextStyle,
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            //When clicked we want to pop off this second screen and show up the first screen .
            //it is done by .pop and pass the current context .
            onPress: () {
              Navigator.pop(context);
            },
            text: 'RE-CALCULATE',
          )
        ],
      ),
    );
  }
}
