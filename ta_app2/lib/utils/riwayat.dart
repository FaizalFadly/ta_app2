import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> sendPrediction(
    double temperature, double nutrient, String prediction) async {
  final response = await http.post(
    Uri.parse('http:192.168.1.2:800/api/predictions'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'temperature': temperature,
      'nutrient': nutrient,
      'prediction': prediction,
    }),
  );

  if (response.statusCode == 201) {
    print('Prediction saved successfully');
  } else {
    print('Failed to save prediction');
  }
}
