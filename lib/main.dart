import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController inputController1 = TextEditingController();
  TextEditingController inputController2 = TextEditingController();
  TextEditingController inputController3 = TextEditingController();
  TextEditingController inputController4 = TextEditingController();

  String predictionResult = ''; // Store the prediction result

  Future<void> sendPredictionRequest() async {
    try {
      final response = await http.post(
        Uri.parse('https://test-xclm.onrender.com/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'features': [
            int.parse(inputController1.text),
            int.parse(inputController2.text),
            int.parse(inputController3.text),
            int.parse(inputController4.text),
          ],
        }),
      );

      if (response.statusCode == 200) {
        print('Nigana');
        setState(() {
          predictionResult =
              'Prediction: ${jsonDecode(response.body)['prediction']}';
        });
      } else {
        print("failed");
        predictionResult = 'Failed to get prediction';
      }
    } catch (error) {
      setState(() {
        print("nag error");
        predictionResult = 'Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: inputController1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Input 1'),
            ),
            TextField(
              controller: inputController2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Input 2'),
            ),
            TextField(
              controller: inputController3,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Input 3'),
            ),
            TextField(
              controller: inputController4,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Input 4'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                sendPredictionRequest();
              },
              child: const Text('Predict'),
            ),
            const SizedBox(height: 20),
            Text(
              'Prediction: $predictionResult',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: predictionResult.startsWith('Prediction')
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
