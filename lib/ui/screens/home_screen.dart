import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Marathi Bhakti Status Maker"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Category",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),

            _buildCategory(context, "गणपती", "ganpati"),
            _buildCategory(context, "विठ्ठल", "vitthal"),
            _buildCategory(context, "साईबाबा", "saibaba"),
            _buildCategory(context, "महादेव", "mahadev"),
            _buildCategory(context, "छत्रपती शिवाजी महाराज", "shivaji"),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, String title, String routeName) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push('/category/$routeName'),
    );
  }
}
