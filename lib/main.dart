import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _display = '0';
  double _firstOperand = 0;
  double _secondOperand = 0;
  String _operator = '';
  bool _shouldClearDisplay = false;

  void _inputNumber(String number) {
    setState(() {
      if (_display == '0' || _shouldClearDisplay) {
        _display = number;
        _shouldClearDisplay = false;
      } else {
        _display += number;
      }
    });
  }

  void _inputOperator(String operator) {
    setState(() {
      _firstOperand = double.tryParse(_display) ?? 0;
      _operator = operator;
      _shouldClearDisplay = true;
    });
  }

  void _clear() {
    setState(() {
      _display = '0';
      _firstOperand = 0;
      _secondOperand = 0;
      _operator = '';
      _shouldClearDisplay = false;
    });
  }

  void _calculate() {
    setState(() {
      _secondOperand = double.tryParse(_display) ?? 0;

      switch (_operator) {
        case '+':
          _display = (_firstOperand + _secondOperand).toString();
          break;
        case '-':
          _display = (_firstOperand - _secondOperand).toString();
          break;
        case '*':
          _display = (_firstOperand * _secondOperand).toString();
          break;
        case '/':
          if (_secondOperand != 0) {
            _display = (_firstOperand / _secondOperand).toString();
          } else {
            _display = 'Error';
          }
          break;
        default:
          _display = 'Error';
          break;
      }
      _shouldClearDisplay = true;
    });
  }

  Widget _buildButton(String text, {Color? color, Function()? onPressed}) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 80,
          margin: EdgeInsets.all(5),
          color: color ?? Colors.grey[300],
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _display,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Divider()),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildButton('7', onPressed: () => _inputNumber('7')),
                  _buildButton('8', onPressed: () => _inputNumber('8')),
                  _buildButton('9', onPressed: () => _inputNumber('9')),
                  _buildButton('/', color: Colors.orange, onPressed: () => _inputOperator('/')),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('4', onPressed: () => _inputNumber('4')),
                  _buildButton('5', onPressed: () => _inputNumber('5')),
                  _buildButton('6', onPressed: () => _inputNumber('6')),
                  _buildButton('*', color: Colors.orange, onPressed: () => _inputOperator('*')),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('1', onPressed: () => _inputNumber('1')),
                  _buildButton('2', onPressed: () => _inputNumber('2')),
                  _buildButton('3', onPressed: () => _inputNumber('3')),
                  _buildButton('-', color: Colors.orange, onPressed: () => _inputOperator('-')),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('0', onPressed: () => _inputNumber('0')),
                  _buildButton('C', color: Colors.red, onPressed: _clear),
                  _buildButton('=', color: Colors.green, onPressed: _calculate),
                  _buildButton('+', color: Colors.orange, onPressed: () => _inputOperator('+')),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
