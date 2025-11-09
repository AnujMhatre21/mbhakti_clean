import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/template.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;
  Future<List<TemplateModel>> fetchByDeity(String deity) async {
    final q = await _db.collection('templates')
      .where('deity', isEqualTo: deity)
      .orderBy('popularity_score', descending: true)
      .get();
    return q.docs.map((d) {
      final j = d.data();
      return TemplateModel(
        id: d.id,
        name: (j['name'] ?? '') as String,
        deity: (j['deity'] ?? '') as String,
        thumbUrl: (j['thumb_url'] ?? '') as String,
      );
    }).toList();
  }
}
