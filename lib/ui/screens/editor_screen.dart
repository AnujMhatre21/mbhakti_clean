import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import '../../providers/template_providers.dart';

class EditorScreen extends ConsumerStatefulWidget {
  final String templateId;
  const EditorScreen({super.key, required this.templateId});

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  final _picker = ImagePicker();
  File? _img;

  @override
  Widget build(BuildContext context) {
    final tAsync = ref.watch(templateProvider(widget.templateId));
    return Scaffold(
      appBar: AppBar(title: const Text('फोटो निवडा')),
      body: tAsync.when(
        data: (_) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  final x = await _picker.pickImage(source: ImageSource.gallery);
                  if (x != null) setState(() => _img = File(x.path));
                },
                child: Container(
                  height: 240,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: _img == null
                      ? const Center(child: Icon(Icons.add_a_photo, size: 48))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(_img!, fit: BoxFit.cover),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: _img == null
                          ? null
                          : () async {
                              await Share.shareXFiles(
                                [XFile(_img!.path)],
                                text: 'Bhakti status image',
                              );
                            },
                      child: const Text('Share Image'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Video export comes later.'),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
