import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/category_screen.dart';
import '../ui/screens/template_preview_screen.dart';
import '../ui/screens/editor_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    GoRoute(
      path: '/category/:deity',
      builder: (_, s) => CategoryScreen(deity: s.pathParameters['deity']!),
    ),
    GoRoute(
      path: '/template/:id',
      builder: (_, s) => TemplatePreviewScreen(templateId: s.pathParameters['id']!),
    ),
    GoRoute(
      path: '/editor/:id',
      builder: (_, s) => EditorScreen(templateId: s.pathParameters['id']!),
    ),
  ],
);
