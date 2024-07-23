import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.7:8000'));

  Future<void> sendPrediction(
      double temperature, double nutrient, String prediction) async {
    try {
      final response = await _dio.post(
        'http://192.168.1.7:8000/api/predictions',
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

  Future<void> deletePrediction(int id) async {
    try {
      final response =
          await _dio.delete('http://192.168.1.7:8000/api/notifications/$id');
      if (response.statusCode == 200) {
        print('Notification deleted successfully');
      } else {
        print('Failed to delete notification');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
