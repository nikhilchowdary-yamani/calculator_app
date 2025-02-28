import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String display = '';
  String? operator;
  double? firstOperand;

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        clearDisplay();
      } else if (value == '=') {
        calculateResult();
      } else if ("+-*/".contains(value)) {
        handleOperator(value);
      } else if (value == '.') {
        handleDecimal();
      } else if (value == 'DEL') {
        deleteChar();
      } else {
        display += value;
      }
    });
  }

  void handleOperator(String op) {
    if (firstOperand == null) {
      firstOperand = double.tryParse(display);
      if (firstOperand != null) {
        operator = op;
        display += op;
      }
    } else {
      calculateResult();
      operator = op;
      display += op;
    }
  }

  void handleDecimal() {
    if (!display.contains('.')) {
      display += '.';
    } else if (display.isNotEmpty && "+-*/".contains(display[display.length - 1])) {
      display += '.';
    } else if (display.isNotEmpty &&
        (operator != null &&
            display.substring(display.lastIndexOf(RegExp(r'[+\-*/]')) + 1).contains('.') == false)) {
      display += '.';
    }
  }

  void calculateResult() {
    if (firstOperand != null && operator != null && display.isNotEmpty) {
      String secondOperandStr = display.substring(display.lastIndexOf(operator!) + 1);

      double secondOperand = double.tryParse(secondOperandStr) ?? 0;
      double result = 0;
      switch (operator) {
        case '+':
          result = firstOperand! + secondOperand;
          break;
        case '-':
          result = firstOperand! - secondOperand;
          break;
        case '*':
          result = firstOperand! * secondOperand;
          break;
        case '/':
          if (secondOperand != 0) {
            result = firstOperand! / secondOperand;
          } else {
            display = 'Error';
            return;
          }
          break;
      }
      display = result.toString();
      firstOperand = result;
      operator = null;
    }
  }

  void clearDisplay() {
    setState(() {
      display = '';
      operator = null;
      firstOperand = null;
    });
  }

  void deleteChar() {
    setState(() {
      if (display.isNotEmpty) {
        display = display.substring(0, display.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Text(
                display,
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.2,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                return CalculatorButton(
                  text: buttons[index],
                  onPressed: () {
                    buttonPressed(buttons[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  final List<String> buttons = [
    '7', '8', '9', '/',
    '4', '5', '6', '*',
    '1', '2', '3', '-',
    'C', '0', '.', '+',
    '=', 'DEL',
  ];
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CalculatorButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}