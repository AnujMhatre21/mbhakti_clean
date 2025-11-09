import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/firestore_service.dart';
import '../models/template.dart';

final firestoreServiceProvider = Provider((_) => FirestoreService());

final deityTemplatesProvider =
    FutureProvider.family<List<TemplateModel>, String>((ref, deity) {
  return ref.read(firestoreServiceProvider).fetchByDeity(deity);
});

final templateProvider =
    FutureProvider.family<TemplateModel, String>((ref, id) {
  return ref.read(firestoreServiceProvider).fetchById(id);
});
