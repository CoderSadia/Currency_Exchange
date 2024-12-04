import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _amountController = TextEditingController();
  double? _convertedAmount;
  String _fromCurrency = 'USD';
  String _toCurrency = 'BDT';

  // Example exchange rates (you can replace these with dynamic API calls)
  final Map<String, double> exchangeRates = {
    'USD': 1.0, // 1 USD = 1 USD
    'EUR': 0.85, // 1 USD = 0.85 EUR
    'INR': 74.5, // 1 USD = 74.5 INR
    'GBP': 0.75, // 1 USD = 0.75 GBP
    'BDT': 108.0, // 1 USD = 108 BDT (Example rate, this can change)
  };

  // Currency conversion function
  void _convertCurrency() {
    final double? amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      Fluttertoast.showToast(msg: "Please enter a valid amount");
      return;
    }

    final double exchangeRate =
        exchangeRates[_toCurrency]! / exchangeRates[_fromCurrency]!;
    final double convertedAmount = amount * exchangeRate;

    setState(() {
      _convertedAmount = convertedAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Currency Exchange')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _fromCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _fromCurrency = newValue!;
                });
              },
              items: exchangeRates.keys.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _toCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _toCurrency = newValue!;
                });
              },
              items: exchangeRates.keys.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16),
            if (_convertedAmount != null)
              Text(
                'Converted Amount: ${_convertedAmount!.toStringAsFixed(2)} $_toCurrency',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
