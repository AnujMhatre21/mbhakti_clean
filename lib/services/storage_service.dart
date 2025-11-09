import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import '../models/template.dart';

class StorageService {
  Future<String> localizeToTemp(String url) async {
    late List<int> bytes; late String name;
    if (url.startsWith('asset:')) {
      final p = 'assets/sample/${url.split(':').last}';
      final d = await rootBundle.load(p);
      bytes = d.buffer.asUint8List(); name = url.split(':').last;
    } else {
      final r = await http.get(Uri.parse(url));
      bytes = r.bodyBytes; name = Uri.parse(url).pathSegments.last;
    }
    final f = File('${Directory.systemTemp.path}/$name');
    await f.writeAsBytes(bytes, flush: true);
    return f.path;
  }

  Future<List<PlaceholderSlot>> loadPlaceholders(String url) async {
    final String js;
    if (url.startsWith('asset:')) {
      js = await rootBundle.loadString('assets/sample/${url.split(':').last}');
    } else {
      js = (await http.get(Uri.parse(url))).body;
    }
    final j = jsonDecode(js) as Map<String,dynamic>;
    final arr = (j['placeholders'] as List).cast<Map<String,dynamic>>();
    return arr.map(PlaceholderSlot.fromJson).toList();
  }
}
