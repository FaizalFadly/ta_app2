import 'package:dio/dio.dart';

import '../models/notification_model.dart';

class ApiService {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'http://10.0.164.111:8000/api/predictions'));

  Future<int?> sendPrediction(
    String sensorId,
    double temperature,
    double nutrient,
    String prediction,
  ) async {
    try {
      final url = 'http://10.0.164.111:8000/api/predictions';

      final response = await _dio.post(
        url,
        data: {
          'sensor_id': sensorId,
          'temperature': temperature,
          'nutrient': nutrient,
          'prediction': prediction,
        },
      );
      print('Response data: ${response.data}'); // Print data respon
      if (response.statusCode == 201) {
        return response.data['id'];
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response data: ${response.data}');
      }
    } on DioException catch (e) {
      print('Error: $e');
      print('Request failed with status: ${e.response?.statusCode}');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
      }
      rethrow;
    }
    return null;
  }

  Future<void> deletePrediction(int id) async {
    try {
      final String url = 'http://10.0.164.111:8000/api/predictions/$id';
      print('Deleting prediction with id: $id at URL: $url');
      final response = await _dio.delete(url);
      if (response.statusCode == 200) {
        print('Prediction deleted successfully.');
      } else {
        print('Failed to delete prediction: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting prediction: $e');
    }
  }

  Future<void> sendNotification(
      String title, String message, String dateTime) async {
    try {
      final url = 'http://10.0.164.111:8000/api/notifications';
      final response = await _dio.post(
        url,
        data: {
          'title': title,
          'message': message,
          'dateTime': dateTime,
        },
      );
      if (response.statusCode == 201) {
        print('Notification sent successfully.');
      } else {
        print('Failed to send notification: ${response.statusCode}');
        print('Response data: ${response.data}');
      }
    } on DioException catch (e) {
      print('Error sending notification: $e');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
      }
      rethrow;
    }
  }

  // Future<List<NotificationItem>> fetchNotifications() async {
  //   try {
  //     final url = 'http://10.0.164.111:8000/api/notifications';
  //     final response = await _dio.get(url); // Pastikan metode GET
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = response.data;
  //       return data.map((item) => NotificationItem.fromJson(item)).toList();
  //     } else {
  //       print('Failed to fetch notifications: ${response.statusCode}');
  //     }
  //   } on DioException catch (e) {
  //     print('Error fetching notifications: $e');
  //     if (e.response != null) {
  //       print('Response data: ${e.response?.data}');
  //     }
  //     rethrow;
  //   }
  //   return [];
  // }
}
