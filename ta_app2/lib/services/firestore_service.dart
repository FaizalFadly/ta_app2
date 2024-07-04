// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:app_ta/models/plant_data.dart';

// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   Future<void> addPlantData(PlantData data) {
//     return _db.collection('plants_data').add(data.toMap());
//   }

//   Future<List<PlantData>> getPlantData() async {
//     var snapshot = await _db.collection('plants_data').get();
//     return snapshot.docs
//         .map((doc) => PlantData.fromMap(doc.data() as Map<String, dynamic>))
//         .toList();
//   }
// }
