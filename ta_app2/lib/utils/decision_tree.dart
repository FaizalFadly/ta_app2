import 'package:ta_app2/models/plant_data.dart';

class DecisionTree {
  final List<PlantData> data;

  DecisionTree(this.data);

  String predict(double temperature, double nutrients) {
    // Implementasi decision tree sederhana
    if (temperature > 30) {
      return 'bad';
    } else if (nutrients < 30) {
      return 'average';
    } else {
      return 'good';
    }
  }
}
