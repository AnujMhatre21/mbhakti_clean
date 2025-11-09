import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
// add imports
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/template_providers.dart'; // adjust path

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const Home(),
    ),
    GoRoute(
      path: '/category/:deity',
      builder: (_, s) => Category(deity: s.pathParameters['deity']!),
    ),
  ],
);

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('MBhakti')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 12, runSpacing: 12,
        children: [
          ActionChip(label: const Text('गणपती'),
            onPressed: () => router.go('/category/ganpati')),
        ],
      ),
    ),
  );
}




class Category extends ConsumerWidget {
  final String deity;
  const Category({super.key, required this.deity});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(deityTemplatesProvider(deity));
    return Scaffold(
      appBar: AppBar(title: Text('Category: $deity')),
      body: async.when(
        data: (list) => GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 9/16, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemCount: list.length,
          itemBuilder: (c, i) {
            final t = list[i];
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(fit: StackFit.expand, children: [
                CachedNetworkImage(imageUrl: t.thumbUrl, fit: BoxFit.cover),
                Align(alignment: Alignment.bottomCenter, child: Container(
                  color: Colors.black45, padding: const EdgeInsets.all(6),
                  child: Text(t.name, style: const TextStyle(color: Colors.white)),
                )),
              ]),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

