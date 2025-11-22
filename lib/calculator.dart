import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _display = '0';
  String _expression = '';
  double _operand1 = 0;
  double _operand2 = 0;
  String _operation = '';
  bool _shouldResetDisplay = false;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _clear();
      } else if (buttonText == '=') {
        _calculate();
      } else if (['+', '-', '×', '÷'].contains(buttonText)) {
        _handleOperation(buttonText);
      } else if (buttonText == '.') {
        _handleDecimal();
      } else {
        _handleNumber(buttonText);
      }
    });
  }

  void _clear() {
    _display = '0';
    _expression = '';
    _operand1 = 0;
    _operand2 = 0;
    _operation = '';
    _shouldResetDisplay = false;
  }

  void _handleNumber(String number) {
    if (_shouldResetDisplay) {
      _display = number;
      _shouldResetDisplay = false;
    } else {
      if (_display == '0') {
        _display = number;
      } else {
        _display += number;
      }
    }
  }

  void _handleDecimal() {
    if (_shouldResetDisplay) {
      _display = '0.';
      _shouldResetDisplay = false;
    } else if (!_display.contains('.')) {
      _display += '.';
    }
  }

  void _handleOperation(String op) {
    if (_operation.isNotEmpty && !_shouldResetDisplay) {
      _calculate();
    }
    _operand1 = double.parse(_display);
    _operation = op;
    _expression = '$_display $op';
    _shouldResetDisplay = true;
  }

  void _calculate() {
    if (_operation.isEmpty) return;

    _operand2 = double.parse(_display);
    double result = 0;

    switch (_operation) {
      case '+':
        result = _operand1 + _operand2;
        break;
      case '-':
        result = _operand1 - _operand2;
        break;
      case '×':
        result = _operand1 * _operand2;
        break;
      case '÷':
        if (_operand2 == 0) {
          _display = 'Error';
          _operation = '';
          _shouldResetDisplay = true;
          return;
        }
        result = _operand1 / _operand2;
        break;
    }

    _display = _formatResult(result);
    _expression = '$_operand1 $_operation $_operand2 =';
    _operation = '';
    _shouldResetDisplay = true;
  }

  String _formatResult(double result) {
    if (result % 1 == 0) {
      return result.toInt().toString();
    } else {
      return result
          .toStringAsFixed(10)
          .replaceAll(RegExp(r'0*$'), '')
          .replaceAll(RegExp(r'\.$'), '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            // Display Section
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (_expression.isNotEmpty)
                      Text(
                        _expression,
                        style: const TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      _display,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            // Buttons Section
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: _buildButton(
                                  'C', const Color(0xFF9E9E9E), Colors.black)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: _buildButton(
                                  '÷', const Color(0xFFFF9500), Colors.white)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: _buildButton(
                                  '×', const Color(0xFFFF9500), Colors.white)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: _buildButton(
                                  '⌫', const Color(0xFF9E9E9E), Colors.black)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: _buildButton(
                                  '7', const Color(0xFF2D2D2D), Colors.white)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: _buildButton(
                                  '8', const Color(0xFF2D2D2D), Colors.white)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: _buildButton(
                                  '9', const Color(0xFF2D2D2D), Colors.white)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: _buildButton(
                                  '-', const Color(0xFFFF9500), Colors.white)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: _buildButton(
                                  '4', const Color(0xFF2D2D2D), Colors.white)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: _buildButton(
                                  '5', const Color(0xFF2D2D2D), Colors.white)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: _buildButton(
                                  '6', const Color(0xFF2D2D2D), Colors.white)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: _buildButton(
                                  '+', const Color(0xFFFF9500), Colors.white)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: _buildButton(
                                              '1',
                                              const Color(0xFF2D2D2D),
                                              Colors.white)),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child: _buildButton(
                                              '2',
                                              const Color(0xFF2D2D2D),
                                              Colors.white)),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child: _buildButton(
                                              '3',
                                              const Color(0xFF2D2D2D),
                                              Colors.white)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: _buildButton(
                                              '0',
                                              const Color(0xFF2D2D2D),
                                              Colors.white)),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child: _buildButton(
                                              '.',
                                              const Color(0xFF2D2D2D),
                                              Colors.white)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildButton(
                                '=', const Color(0xFFFF9500), Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color backgroundColor, Color textColor) {
    return GestureDetector(
      onTap: () {
        if (text == '⌫') {
          setState(() {
            if (_display.length > 1) {
              _display = _display.substring(0, _display.length - 1);
            } else {
              _display = '0';
            }
          });
        } else {
          _onButtonPressed(text);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 32,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
