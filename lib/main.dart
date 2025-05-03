import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430, maxHeight: 712),
          child: homePageScaffold(),
        ),
      ),
    );
  }

  Scaffold homePageScaffold() {
    return Scaffold(
      body: Container(alignment: Alignment.center, child: CalculatorButtons()),
    );
  }
}

class CalculatorButtons extends StatefulWidget {
  const CalculatorButtons({super.key});

  @override
  State<CalculatorButtons> createState() => _CalculatorButtonsState();
}

class _CalculatorButtonsState extends State<CalculatorButtons> {
  final Calculator _viewBox = Calculator();

  void updateCalculatorViewBox(String input) {
    setState(() {
      _viewBox.update(input);
      _viewBox.errorClear();
    });
  }

  void clearCalculatorViewBox() {
    setState(() {
      _viewBox.clear();
    });
  }

  void calculate() {
    setState(() {
      _viewBox.calculate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 300, // Farazi yükseklik (görünür geçmiş sınırı)
          color: const Color(0xcc2f2f2f),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListView.builder(
            reverse: true, // Yeni eklenen eleman alta eklenir
            itemCount: _viewBox.history.length,
            itemBuilder: (context, index) {
              final reversedIndex = _viewBox.history.length - 1 - index;
              final historyEntry = _viewBox.history[reversedIndex];

              final parts = historyEntry.split(' = ');
              final expression = parts[0];
              final result = parts.length > 1 ? parts[1] : '';

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        expression,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 212, 212, 212),
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Text(
                        '=',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        result,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          width: double.infinity,
          color: const Color(0xcc181818),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _viewBox.displayText,
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  _viewBox.displayError,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 192, 192, 192),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: const Color(0xcc050505),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            spacing: 2,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                spacing: 2,
                children: [
                  calculatorRowOne(),
                  calculatorRowTwo(),
                  calculatorRowThree(),
                  calculatorRowFour(),
                  calculatorRowFive(),
                ],
              ),
              Column(children: [calculatorRowRight()]),
            ],
          ),
        ),
      ],
    );
  }

  Row calculatorRowOne() {
    return Row(
      spacing: 2,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CalculatorButton(str: 'C', onPressed: () => clearCalculatorViewBox()),
        CalculatorButton(
          str: '(',
          onPressed: () => updateCalculatorViewBox('('),
        ),
        CalculatorButton(
          str: ')',
          onPressed: () => updateCalculatorViewBox(')'),
        ),
        CalculatorButton(
          str: 'mod',
          onPressed: () => updateCalculatorViewBox('mod'),
        ),
      ],
    );
  }

  Row calculatorRowTwo() {
    return Row(
      spacing: 2,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CalculatorButton(
          str: '7',
          onPressed: () => updateCalculatorViewBox('7'),
          backgroundColor: Color(0xdd7f7f7f),
        ),
        CalculatorButton(
          str: '8',
          onPressed: () => updateCalculatorViewBox('8'),
          backgroundColor: Color(0xdd7f7f7f),
        ),
        CalculatorButton(
          str: '9',
          onPressed: () => updateCalculatorViewBox('9'),
          backgroundColor: Color(0xdd7f7f7f),
        ),
        CalculatorButton(
          str: '÷',
          onPressed: () => updateCalculatorViewBox('÷'),
        ),
      ],
    );
  }

  Row calculatorRowThree() {
    return Row(
      spacing: 2,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CalculatorButton(
          str: '4',
          onPressed: () => updateCalculatorViewBox('4'),
          backgroundColor: Color(0xdd7f7f7f),
        ),
        CalculatorButton(
          str: '5',
          onPressed: () => updateCalculatorViewBox('5'),
          backgroundColor: Color(0xdd7f7f7f),
        ),
        CalculatorButton(
          str: '6',
          onPressed: () => updateCalculatorViewBox('6'),
          backgroundColor: Color(0xdd7f7f7f),
        ),
        CalculatorButton(
          str: 'x',
          onPressed: () => updateCalculatorViewBox('x'),
        ),
      ],
    );
  }

  Row calculatorRowFour() {
    return Row(
      spacing: 2,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CalculatorButton(
          str: '1',
          onPressed: () => updateCalculatorViewBox('1'),
          backgroundColor: Color(0xdd7f7f7f),
        ),
        CalculatorButton(
          str: '2',
          onPressed: () => updateCalculatorViewBox('2'),
          backgroundColor: Color(0xdd7f7f7f),
        ),
        CalculatorButton(
          str: '3',
          onPressed: () => updateCalculatorViewBox('3'),
          backgroundColor: Color(0xdd7f7f7f),
        ),
        CalculatorButton(
          str: '-',
          onPressed: () => updateCalculatorViewBox('-'),
        ),
      ],
    );
  }

  Row calculatorRowFive() {
    return Row(
      spacing: 2,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CalculatorButton(
          str: '0',
          onPressed: () => updateCalculatorViewBox('0'),
          backgroundColor: Color(0xdd7f7f7f),
        ),
        CalculatorButton(
          str: '.',
          onPressed: () => updateCalculatorViewBox('.'),
        ),
        CalculatorButton(
          str: '%',
          onPressed: () => updateCalculatorViewBox('%'),
        ),
        CalculatorButton(
          str: '+',
          onPressed: () => updateCalculatorViewBox('+'),
        ),
      ],
    );
  }

  Column calculatorRowRight() {
    return Column(
      spacing: 2,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CalculatorButton(
          str: 'π',
          onPressed: () => updateCalculatorViewBox('π'),
        ),
        CalculatorButton(
          str: '√',
          onPressed: () => updateCalculatorViewBox('√'),
        ),
        CalculatorButton(
          str: 'x²',
          onPressed: () => updateCalculatorViewBox('x²'),
        ),
        CalculatorButton(
          str: '=',
          height: 122.0,
          backgroundColor: Color(0xCCf7630c),
          onPressed: () => calculate(),
        ),
      ],
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String str;
  final double width;
  final double height;
  final double circular;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const CalculatorButton({
    required this.str,
    this.width = 80.0,
    this.height = 60.0,
    this.circular = 10.0,
    this.backgroundColor = const Color(0xcc575757),
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circular), // Köşe yuvarlaklığı
        ),
      ),
      child: Text(
        str,
        maxLines: 1, // En fazla 1 satır göster
        softWrap: false, // Satır sonu sarmasını kapat
        overflow:
            TextOverflow.visible, // Taşma kontrolü (gerekirse değiştirilir)
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
      ),
    );
  }
}

class Calculator {
  String _displayText = '';
  String _displayError = '';
  final List<String> _history = [];

  String get displayText => _displayText;
  String get displayError => _displayError;
  List<String> get history =>
      List.unmodifiable(_history); // dışarıdan sadece okunabilir

  void update(String input) {
    _displayText += input;
  }

  void clear() {
    _displayText = '';
    _displayError = '';
  }

  void errorClear() {
    _displayError = '';
  }

  void calculate() {
    try {
      String parsedExpression = _parseExpression(_displayText);
      double result = _evaluate(parsedExpression);
      _history.add('$_displayText = $result');
      _displayText = result.toString();
      _displayError = '';

      if (result == result.toInt()) {
        _displayText = result.toInt().toString();
      } else {
        _displayText = result.toString();
      }
    } catch (e) {
      _displayError = 'Malformed expression';
    }
  }

  String _parseExpression(String expr) {
    expr = expr.replaceAll('π', pi.toString());
    expr = expr.replaceAll('x²', '^2');
    expr = expr.replaceAll('x', '*');
    expr = expr.replaceAll('÷', '/');
    expr = expr.replaceAll('√', 'sqrt');

    // Yüzde işareti: "50%" → "50/100"
    expr = expr.replaceAllMapped(RegExp(r'(\d+)%'), (match) {
      return '(${match.group(1)}/100)';
    });

    // "mod" → "%" operatörüne dönüşecek (mod alma işlemi)
    expr = expr.replaceAll('mod', '%');

    return expr;
  }

  double _evaluate(String expr) {
    Parser parser = Parser();
    Expression expression = parser.parse(expr);
    ContextModel context = ContextModel();
    return expression.evaluate(EvaluationType.REAL, context);
  }
}
