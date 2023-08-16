import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorKeyboard extends StatelessWidget {
  final TextEditingController amountController;

  const CalculatorKeyboard({required this.amountController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.grey[200],
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                buildButton('AC', textColor: Colors.red),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                buildButton('4'),
                buildButton('5'),
                buildButton('6'),
                buildButton('/', textColor: Colors.orange),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                buildButton('1'),
                buildButton('2'),
                buildButton('3'),
                buildButton('*', textColor: Colors.orange),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                buildButton('.'),
                buildButton('0'),
                buildButton('='),
                buildButton('-', textColor: Colors.orange),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                // buildButton('AC', flex: 2, textColor: Colors.red),
                buildButton('+', textColor: Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String buttonText, {int flex = 1, Color textColor = Colors.black}) {
    return Expanded(
      flex: flex,
      child: TextButton(
        onPressed: () {
          if (buttonText == '=') {
            // Evaluate the expression
            try {
              final result = evalExpression(amountController.text);
              amountController.text = result.toString();
            } catch (e) {
              // Handle any exception during evaluation
              amountController.text = 'Error';
            }
          } else if (buttonText == 'AC') {
            // Clear the text
            amountController.clear();
          } else {
            // Append the button text to the input
            amountController.text += buttonText;
          }
        },
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24, color: textColor),
        ),
      ),
    );
  }

  double evalExpression(String expression) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval;
    } catch (e) {
      throw Exception('Invalid expression');
    }
  }
}
