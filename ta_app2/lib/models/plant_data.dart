class PlantData {
  final double Suhu;
  final double Nutrisi;
  final String label;

  PlantData({required this.Suhu, required this.Nutrisi, required this.label});

  factory PlantData.fromMap(Map<String, dynamic> data) {
    return PlantData(
      Suhu: data['Suhu'],
      Nutrisi: data['Nutrisi'],
      label: data['label'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Suhu': Suhu,
      'Nutrisi': Nutrisi,
      'label': label,
    };
  }
}
            