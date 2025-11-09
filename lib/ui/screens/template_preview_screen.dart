// lib/ui/screens/template_preview_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/template_providers.dart';
import '../../models/template.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TemplatePreviewScreen extends ConsumerWidget {
  final String templateId;
  const TemplatePreviewScreen({super.key, required this.templateId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(templateProvider(templateId));

    return Scaffold(
      appBar: AppBar(title: const Text('प्रिव्ह्यू')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (TemplateModel t) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Use thumbnail as the visual preview (fast & reliable)
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: CachedNetworkImage(
                          imageUrl: t.thumbUrl,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (_, __, ___) => Container(
                            color: Colors.black,
                            alignment: Alignment.center,
                            child: const Text('Preview unavailable',
                                style: TextStyle(color: Colors.white70)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Meta row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          t.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('${t.durationS.toStringAsFixed(0)}s',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Proceed to editor
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => context.push('/editor/${t.id}'),
                      child: const Text('फोटो लावा'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
