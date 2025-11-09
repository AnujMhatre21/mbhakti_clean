import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/template.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<List<TemplateModel>> fetchByDeity(String deity) async {
    final qs = await _db
        .collection('templates')
        .where('deity', isEqualTo: deity)
        .orderBy('popularity_score', descending: true)
        .get();
    return qs.docs.map(_fromDoc).toList(growable: false);
  }

  Future<TemplateModel> fetchById(String id) async {
    final d = await _db.collection('templates').doc(id).get();
    if (!d.exists) throw StateError('Template $id not found');
    return _fromDoc(d);
  }

  TemplateModel _fromDoc(DocumentSnapshot<Map<String, dynamic>> d) {
    final j = d.data() ?? const <String, dynamic>{};
    double toD(Object? v, [double def = 0]) => v is num ? v.toDouble() : def;
    String toS(Object? v, [String def = '']) => v is String ? v : def;

    return TemplateModel(
      id: d.id,
      name: toS(j['name']),
      deity: toS(j['deity']),
      thumbUrl: toS(j['thumb_url']),
      durationS: toD(j['duration_s'], 10),
      videoUrl: toS(j['video_url'], 'asset:base_video.mp4'),
      musicUrl: toS(j['music_url'], 'asset:music.mp3'),
      placeholderConfigUrl: toS(j['placeholder_config_url'], 'asset:placeholder.json'),
    );
  }
}
