import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/template_providers.dart';
import '../../models/template.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryScreen extends ConsumerWidget {
  final String deity;
  const CategoryScreen({super.key, required this.deity});

  String getTitle() {
    switch (deity) {
      case 'ganpati': return 'गणपती';
      case 'vitthal': return 'विठ्ठल';
      case 'shivaji': return 'छत्रपती शिवाजी महाराज';
      case 'saibaba': return 'साईबाबा';
      case 'mahadev': return 'महादेव';
      default: return 'टेम्प्लेट्स';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(deityTemplatesProvider(deity));

    return Scaffold(
      appBar: AppBar(title: Text(getTitle())),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (List<TemplateModel> templates) {
          if (templates.isEmpty) {
            return const Center(child: Text("No templates available"));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,        // two per row
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 9 / 16, // vertical card shape
            ),
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final t = templates[index];
              return InkWell(
                onTap: () => context.push('/template/${t.id}'),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: t.thumbUrl,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          color: Colors.black45,
                          child: Text(
                            t.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
