import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameFastMath extends StatefulWidget {
  const GameFastMath({super.key});

  @override
  _GameFastMathState createState() => _GameFastMathState();
}

class _GameFastMathState extends State<GameFastMath> {
  // Game state variables
  int _number1 = 0;
  int _number2 = 0;
  String _operator = '+';
  String _question = '';
  String _answer = '';
  bool _isCorrect = false;
  bool _answerSubmitted = false;
  final TextEditingController _textEditingController = TextEditingController();

  // Function to generate a random math question
  void _generateQuestion() {
    final Random random = Random();
    _number1 = random.nextInt(9) + 1; // Numbers from 1 to 9
    _number2 = random.nextInt(9) + 1;
    _operator = ['+', '-', '*'][random.nextInt(3)]; // +, -, *

    // Construct the question string
    _question = '$_number1 $_operator $_number2 = ';
    _answer = ''; //reset answer
    _isCorrect = false; // Reset
    _answerSubmitted = false;
    _textEditingController.clear(); // Clear the text field
    setState(
        () {}); // Update the UI with the new question and cleared text field
  }

  // Function to check the answer
  void _checkAnswer() {
    int correctAnswer = 0;
    switch (_operator) {
      case '+':
        correctAnswer = _number1 + _number2;
        break;
      case '-':
        correctAnswer = _number1 - _number2;
        break;
      case '*':
        correctAnswer = _number1 * _number2;
        break;
    }

    // Parse the user's answer and check for validity
    int? userAnswer = int.tryParse(_textEditingController.text);
    if (userAnswer != null) {
      if (userAnswer == correctAnswer) {
        _isCorrect = true;
      } else {
        _isCorrect = false;
      }
      _answerSubmitted = true;
    } else {
      _isCorrect = false;
      _answerSubmitted = true;
    }

    if (_isCorrect) {
      // If the answer is correct, generate the next question after a delay
      Future.delayed(const Duration(seconds: 1), () {
        _generateQuestion();
      });
    }
    setState(() {});
  }

  // Function to handle number button presses
  void _onNumberPressed(String number) {
    setState(() {
      _textEditingController.text += number;
    });
  }

  // Function to handle the "Enter" button press
  void _onEnterPressed() {
    _checkAnswer();
  }

  // Function to handle the "Clear" button press
  void _onClearPressed() {
    setState(() {
      _textEditingController.text = '';
    });
  }

  // Function to handle the "Delete" button press
  void _onDeletePressed() {
    setState(() {
      if (_textEditingController.text.isNotEmpty) {
        _textEditingController.text = _textEditingController.text
            .substring(0, _textEditingController.text.length - 1);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _generateQuestion(); // Generate the first question when the widget is initialized
  }

  @override
  void dispose() {
    _textEditingController
        .dispose(); // Dispose the controller to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color numberButtonColor = Colors.blue;
    final Color enterButtonColor = Colors.blue.shade700;
    const Color deleteButtonColor = Colors.redAccent;
    const Color clearButtonColor = Colors.green;
    const TextStyle buttonTextStyle = TextStyle(fontSize: 24.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fast Math Game'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Question Display
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _generateQuestion,
            ),
            const SizedBox(width: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _question,
                  style: const TextStyle(fontSize: 24.0),
                ),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _textEditingController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 24.0),
                    textAlign: TextAlign.center,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0), // Set the border color
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      fillColor: Colors.transparent,
                      filled: true,
                      focusColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0), // Set the border color
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onSubmitted: (_) =>
                        _checkAnswer(), //check answer when user presses enter
                  ),
                ),
                // Show checkmark or cross based on the answer
                if (_answerSubmitted)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      _isCorrect ? Icons.check_circle : Icons.cancel,
                      color: _isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20.0),
            // Calculator Keyboard
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNumberButton('-',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                    _buildNumberButton('+',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                    _buildNumberButton('*',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                    _buildNumberButton('/',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNumberButton('1',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                    _buildNumberButton('2',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                    _buildNumberButton('3',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                    _buildNumberButton('C',
                        onPressed: _onClearPressed,
                        buttonColor: clearButtonColor,
                        textStyle: buttonTextStyle),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNumberButton('4',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                    _buildNumberButton('5',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                    _buildNumberButton('6',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                    _buildNumberButton('D',
                        onPressed: _onDeletePressed,
                        buttonColor: deleteButtonColor,
                        textStyle: buttonTextStyle),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNumberButton('7',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                    _buildNumberButton('8',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                    _buildNumberButton('9',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                    _buildNumberButton('=',
                        onPressed: _onEnterPressed,
                        buttonColor: enterButtonColor,
                        textStyle: buttonTextStyle),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNumberButton('0',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                    _buildNumberButton('.',
                        buttonColor: numberButtonColor,
                        textStyle: buttonTextStyle),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a number button
  Widget _buildNumberButton(String number,
      {VoidCallback? onPressed, Color? buttonColor, TextStyle? textStyle}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: onPressed ?? () => _onNumberPressed(number),
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          number,
          style: textStyle,
        ),
      ),
    );
  }
}
