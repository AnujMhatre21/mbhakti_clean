import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/firestore_service.dart';
import '../models/template.dart';

final firestoreServiceProvider = Provider((_) => FirestoreService());
final deityTemplatesProvider = FutureProvider.family<List<TemplateModel>, String>((ref, deity) async {
  return ref.read(firestoreServiceProvider).fetchByDeity(deity);
});
