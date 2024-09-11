class SensorData {
  final double temperature;
  final double nutrient;

  SensorData({required this.temperature, required this.nutrient});

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      temperature: json['temperature'],
      nutrient: json['nutrient'],
    );
  }
}
