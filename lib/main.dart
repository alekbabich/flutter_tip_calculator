import 'package:flutter/material.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final controller = TextEditingController();

  final List<bool> _selection = [true, false, false];

  String tip = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (tip != '')
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  tip,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
            const Text('Total Amount'),
            SizedBox(
              width: 100,
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: '\$100.00'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ToggleButtons(
                  isSelected: _selection,
                  onPressed: updateSelection,
                  children: const [Text('10%'), Text('15%'), Text('20%')]),
            ),
            TextButton(
              onPressed: () {
                calculateTip();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Calculate Tip'),
            )
          ],
        ),
      ),
    ));
  }

  void updateSelection(int selectedIndex) {
    setState(() {
      for (int i = 0; i < _selection.length; i++) {
        _selection[i] = selectedIndex == i;
      }
    });
  }

  void calculateTip() {
    if (controller.text.isNotEmpty) {
      final totalAmount = double.parse(controller.text);
      final selectedIndex = _selection.indexWhere((element) => element);
      final tipPercentage = [0.1, 0.15, 0.2][selectedIndex];

      final tipTotal = (totalAmount * tipPercentage).toStringAsFixed(2);

      setState(() {
        tip = '\$$tipTotal';
      });
    }
  }
}
