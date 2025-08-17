import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _lastNumberController = TextEditingController();
  double _result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _firstNumberController,
              decoration: InputDecoration(
                labelText: 'First Number',
                hintText: 'Enter your first number',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16), // Add spacing between fields()
            TextField(
              controller: _lastNumberController,
              decoration: InputDecoration(
                labelText: 'Last Number',
                hintText: 'Enter your last number',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: _addNumbers,
                  icon: Icon(Icons.add),
                  label: Text('Add'),
                ),
                ElevatedButton.icon(
                  onPressed: _subNumbers,
                  icon: Icon(Icons.remove),
                  label: Text('Sub'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: _multiPly,
                  icon: Icon(Icons.star),
                  label: Text('Multiply'),
                ),
                ElevatedButton.icon(
                  onPressed: _division,
                  icon: Icon(Icons.ac_unit_outlined),
                  label: Text('Division'),
                ),
              ],
            ),
            SizedBox(height: 25),
            Text('Result: $_result'),
          ],
        ),
      ),
    );
  }

  void _addNumbers() {
    final firstNumber = double.tryParse(_firstNumberController.text) ?? 0;
    final lastNumber = double.tryParse(_lastNumberController.text) ?? 0;
    setState(() {
      _result = firstNumber + lastNumber;
    });
  }

  void _subNumbers() {
    final firstNumber = double.tryParse(_firstNumberController.text) ?? 0;
    final lastNumber = double.tryParse(_lastNumberController.text) ?? 0;
    setState(() {
      _result = firstNumber - lastNumber;
    });
  }

  void _multiPly() {
    final firstNumber = double.tryParse(_firstNumberController.text) ?? 0;
    final lastNumber = double.tryParse(_lastNumberController.text) ?? 0;
    setState(() {
      _result = firstNumber * lastNumber;
    });
  }

  void _division() {
    final firstNumber = double.tryParse(_firstNumberController.text) ?? 0;
    final lastNumber = double.tryParse(_lastNumberController.text) ?? 0;
    setState(() {
      _result = firstNumber / lastNumber;
    });
  }

  @override
  void dispose() {
    _firstNumberController.dispose();
    _lastNumberController.dispose();
    super.dispose();
  }
}
