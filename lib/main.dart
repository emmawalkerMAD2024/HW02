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
  String _keystrokes = ''; 
  double _firstOperand = 0;
  double _secondOperand = 0;
  String _operator = '';
  bool _shouldClearDisplay = false;
  List<String> _history = []; 

  void _inputNumber(String number) {
    setState(() {
      if (_display == '0' || _shouldClearDisplay) {
        _display = number;
        _shouldClearDisplay = false;
      } else {
        _display += number;
      }
      _keystrokes += number; 
    });
  }

  void _inputOperator(String operator) {
    setState(() {
      _firstOperand = double.tryParse(_display) ?? 0;
      _operator = operator;
      _shouldClearDisplay = true;
      _keystrokes += ' $operator '; 
    });
  }

  void _clear() {
    setState(() {
      _display = '0';
      _keystrokes = ''; 
      _firstOperand = 0;
      _secondOperand = 0;
      _operator = '';
      _shouldClearDisplay = false;
    });
  }

  void _calculate() {
    setState(() {
      _secondOperand = double.tryParse(_display) ?? 0;
      String result;

      switch (_operator) {
        case '+':
          result = (_firstOperand + _secondOperand).toString();
          break;
        case '-':
          result = (_firstOperand - _secondOperand).toString();
          break;
        case '*':
          result = (_firstOperand * _secondOperand).toString();
          break;
        case '/':
          if (_secondOperand != 0) {
            result = (_firstOperand / _secondOperand).toString();
          } else {
            result = 'Error';
          }
          break;
        default:
          result = 'Error';
          break;
      }

      if (result != 'Error') {
        _history.add('$_keystrokes = $result');
      } else {
        _history.add('$_keystrokes = Error');
      }

      _display = result;
      _keystrokes = ''; 
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _keystrokes,
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
                Text(
                  _display,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Divider(),

          Expanded(
            child: ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _history[index],
                    style: TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),

          // Buttons layout
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
