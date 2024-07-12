import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<void> sendPrediction(
      double temperature, double nutrient, String prediction) async {
    try {
      final response = await _dio.post(
        'http://192.168.1.2:8000/api/predictions',
        data: {
          'temperature': temperature,
          'nutrient': nutrient,
          'prediction': prediction,
        },
      );
      if (response.statusCode == 201) {
        print('Prediction saved successfully');
      } else {
        print('Failed to save prediction');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
