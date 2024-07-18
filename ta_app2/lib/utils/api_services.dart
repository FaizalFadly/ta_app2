import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.5:8000'));

  Future<void> sendPrediction(
      double temperature, double nutrient, String prediction) async {
    try {
      final response = await _dio.post(
        'http://192.168.1.5:8000/api/predictions',
        data: {
          'temperature': temperature,
          'nutrient': nutrient,
          
          'prediction': prediction,
        },
      );
      print(response.data);
    } on DioException catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}

