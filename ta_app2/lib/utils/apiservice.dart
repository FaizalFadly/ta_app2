import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<void> sendPrediction(
      double temperature, double nutrient, String prediction) async {
    try {
      final response = await _dio.post(
        'http://192.168.1.5:8000/api/kira_kira/predict',
        data: {
          'temperature': temperature,
          'nutrient': nutrient,
        },
      );
      print('Response data: ${response.data}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<dynamic>> getPredictions() async {
    try {
      final response =
          await _dio.get('http://192.168.1.5:8000/api/kira_kira/predict');
      return response.data;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
