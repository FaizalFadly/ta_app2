import 'package:dio/dio.dart';

class PlantDataService {
  final Dio _dio = Dio(BaseOptions(
    validateStatus: (status) {
      return status! >= 200 &&
          status < 500; // Handle all statuses between 200 and 499
    },
  ));

  // Fungsi untuk mengambil semua data tanaman
  // Future<List<dynamic>> getAllPlantData() async {
  //   try {
  //     Response response = await _dio.get('http://192.168.100.156:8000/api');
  //     return response.data;
  //   } catch (e) {
  //     print('Error fetching plant data: $e');
  //     return [];
  //   }
  // }

  // Fungsi untuk mengambil data tanaman berdasarkan suhu dan nutrisi
  Future<List<String>> getPlantDataByTemperatureAndNutrient(
      double temperature, String nutrisi) async {
    try {
      Response response = await _dio
          .get('http://192.168.100.156:8000/api/plant-data', queryParameters: {
        'temperature': temperature.toString(),
        'nutrisi': nutrisi,
      });

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<String> classes = [];
        for (var item in data) {
          // Pastikan item['class'] diubah menjadi string sebelum ditambahkan ke classes
          classes.add(item['class'].toString());
        }

        return classes;
      } else if (response.statusCode == 404) {
        print(
            '404 Not Found: Plant data not found for the given temperature and nutrient values.');
        return []; // or handle as appropriate for your application
      } else {
        print('Failed to load plant data. Status Code: ${response.statusCode}');
        return []; // or handle as appropriate for your application
      }
    } catch (e) {
      print('Error fetching plant data: $e');
      return []; // or handle as appropriate for your application
    }
  }
}
