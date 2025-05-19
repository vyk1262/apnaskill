import 'package:flutter/material.dart';
import 'dart:math';

class GameNumberSeries extends StatefulWidget {
  @override
  _GameNumberSeriesState createState() => _GameNumberSeriesState();
}

class _GameNumberSeriesState extends State<GameNumberSeries> {
  List<int> series = [];
  int correctAnswer = 0;
  TextEditingController guessController = TextEditingController();
  String feedback = "";
  String mode = "+"; // Default mode

  @override
  void initState() {
    super.initState();
    _generateNewSeries();
  }

  void _generateNewSeries() {
    Random random = Random();
    int start = random.nextInt(15) + 1;
    int diff = random.nextInt(8) + 1;
    series = [];

    switch (mode) {
      case "+":
        for (int i = 0; i < 8; i++) {
          series.add(start + i * diff);
        }
        correctAnswer = series.last;
        series.removeLast();
        break;
      case "-":
        for (int i = 0; i < 8; i++) {
          series.add(start - i * diff);
        }
        correctAnswer = series.last;
        series.removeLast();
        break;
      case "*":
        int multiplier = random.nextInt(3) + 2;
        int current = start;
        for (int i = 0; i < 8; i++) {
          series.add(current);
          current *= multiplier;
        }
        correctAnswer = series.last;
        series.removeLast();
        break;
      case "/":
        int eighth =
            (random.nextInt(10) + 2) * pow(random.nextInt(3) + 2, 7).toInt();
        int divisor = random.nextInt(3) + 2;
        int current = eighth;
        List<int> tempSeries = [eighth];
        for (int i = 0; i < 7; i++) {
          current ~/= divisor;
          tempSeries.insert(0, current);
        }
        series = tempSeries.sublist(0, 7);
        correctAnswer = tempSeries[6];
        break;
      case "Mix":
        series = [];
        int currentNumber = random.nextInt(10) + 1;
        series.add(currentNumber);
        for (int i = 1; i < 8; i++) {
          int operation = random.nextInt(4); // 0:+, 1:-, 2:*, 3:/
          int operand = random.nextInt(10) + 1;
          switch (operation) {
            case 0:
              currentNumber += operand;
              break;
            case 1:
              currentNumber -= operand;
              break;
            case 2:
              currentNumber *= operand;
              break;
            case 3:
              if (operand != 0 && currentNumber % operand == 0) {
                currentNumber ~/= operand;
              } else {
                i--;
                continue;
              }
              break;
          }
          if (i < 7) {
            series.add(currentNumber);
          } else {
            correctAnswer = currentNumber;
          }
        }
        break;
      case "Squares":
        start = random.nextInt(10) + 1;
        for (int i = 0; i < 8; i++) {
          series.add(pow(start + i, 2).toInt());
        }
        correctAnswer = series.last;
        series.removeLast();
        break;
      case "Cubes":
        start = random.nextInt(8) + 1;
        for (int i = 0; i < 8; i++) {
          series.add(pow(start + i, 3).toInt());
        }
        correctAnswer = series.last;
        series.removeLast();
        break;
      case "Triangular":
        start = random.nextInt(12) + 1;
        for (int i = 0; i < 8; i++) {
          series.add(((start + i) * (start + i + 1)) ~/ 2);
        }
        correctAnswer = series.last;
        series.removeLast();
        break;
      case "Fibonacci":
        series = [0, 1];
        while (series.length < 8) {
          series.add(series[series.length - 1] + series[series.length - 2]);
        }
        correctAnswer = series.last;
        series.removeLast();
        break;
      case "Arithmetic Varying":
        start = random.nextInt(20) + 1;
        int initialDiff = random.nextInt(5) + 1;
        for (int i = 0; i < 8; i++) {
          series.add(start + (i * (i + 1) ~/ 2) * initialDiff);
        }
        correctAnswer = series.last;
        series.removeLast();
        break;
      case "Geometric Varying":
        start = random.nextInt(10) + 1;
        double initialRatio = (random.nextInt(3) + 2).toDouble();
        double current = start.toDouble();
        series.add(current.toInt());
        for (int i = 1; i < 8; i++) {
          current *= (initialRatio + (i - 1) * 0.5);
          series.add(current.toInt());
        }
        correctAnswer = series.last;
        series.removeLast();
        break;
      case "Alternate Add Subtract":
        start = random.nextInt(20) + 1;
        int add = random.nextInt(10) + 1;
        int subtract = random.nextInt(8) + 1;
        series.add(start);
        for (int i = 1; i < 8; i++) {
          if (i % 2 != 0) {
            start += add;
          } else {
            start -= subtract;
          }
          series.add(start);
        }
        correctAnswer = series.last;
        series.removeLast();
        break;
      case "Alternate Multiply Divide":
        start = random.nextInt(10) + 2;
        int multiply = random.nextInt(3) + 2;
        int divide = random.nextInt(2) + 2;
        double current = start.toDouble();
        series.add(current.toInt());
        for (int i = 1; i < 8; i++) {
          if (i % 2 != 0) {
            current *= multiply;
          } else {
            if (current % divide == 0) {
              current /= divide;
            } else {
              // Retry if division is not whole
              i--;
              continue;
            }
          }
          series.add(current.toInt());
        }
        correctAnswer = series.last;
        series.removeLast();
        break;
    }
    feedback = "";
    guessController.clear();
    setState(() {});
  }

  void _submitGuess() {
    if (guessController.text.isNotEmpty) {
      int guessedAnswer = int.tryParse(guessController.text) ?? -1;
      if (guessedAnswer == correctAnswer) {
        feedback = "Correct!";
      } else {
        feedback = "Incorrect. The correct answer was $correctAnswer.";
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Series Challenge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Complete the series:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '${series.join(', ')}, ?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: guessController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Your Guess for the missing number',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.grey[200],
                filled: true,
                focusColor: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitGuess,
              child: Text('Submit Guess'),
            ),
            SizedBox(height: 20),
            Text(
              feedback,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: feedback == "Correct!" ? Colors.green : Colors.red),
            ),
            SizedBox(height: 20),
            Text('Select Mode:', style: TextStyle(fontSize: 16)),
            Wrap(
              // Using Wrap for better layout on smaller screens
              spacing: 8.0,
              children: <Widget>[
                _buildModeRadioButton("+", "Addition"),
                _buildModeRadioButton("-", "Subtraction"),
                _buildModeRadioButton("*", "Multiplication"),
                _buildModeRadioButton("/", "Division"),
                _buildModeRadioButton("Mix", "Mix"),
                _buildModeRadioButton("Squares", "Squares"),
                _buildModeRadioButton("Cubes", "Cubes"),
                _buildModeRadioButton("Triangular", "Triangular"),
                _buildModeRadioButton("Fibonacci", "Fibonacci"),
                _buildModeRadioButton("Arithmetic Varying", "Arith. Varying"),
                _buildModeRadioButton("Geometric Varying", "Geom. Varying"),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateNewSeries,
              child: Text('New Series'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeRadioButton(String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Radio<String>(
          value: value,
          groupValue: mode,
          onChanged: (newValue) {
            setState(() {
              mode = newValue!;
              _generateNewSeries();
            });
          },
        ),
        Text(label),
      ],
    );
  }
}
