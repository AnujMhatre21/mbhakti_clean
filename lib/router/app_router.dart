import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

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

class Category extends StatelessWidget {
  final String deity;
  const Category({super.key, required this.deity});
  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: Text('Category: $deity')));
}
