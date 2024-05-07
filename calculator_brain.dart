import 'dart:math';

class CalculatorBrain {
  CalculatorBrain({required this.height, required this.weight});
  final int height;
  final int weight;
  late double _bmi;
  String calculateBMI() {
    //this method return string as we need to display the bmi inside text widget which accepts a string
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
    //.toStringAsFixed -> this returns a decimal point string and we can specify how many decimal places we want
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi < 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return 'You have a higher than normal body weight . Try to exercise more .';
    } else if (_bmi < 18.5) {
      return 'You have a normal body weight , Good job !';
    } else {
      return 'You have a lower than normal body weight .You can eat a bit more .';
    }
  }
}
