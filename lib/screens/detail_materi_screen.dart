import 'package:flutter/material.dart';

import '../models/materi_model.dart';
import '../services/api_service.dart';
import '../utils/app_colors.dart';

class DetailMateriScreen extends StatefulWidget {
  final int materiId;

  const DetailMateriScreen({
    super.key,
    required this.materiId,
  });

  @override
  State<DetailMateriScreen> createState() =>
      _DetailMateriScreenState();
}

class _DetailMateriScreenState
    extends State<DetailMateriScreen> {

  late Future<MateriModel> _materi;

  @override
  void initState() {
    super.initState();
    _materi = ApiService.getDetailMateri(widget.materiId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Detail Materi"),
      ),

      body: FutureBuilder<MateriModel>(
        future: _materi,
        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Gagal memuat materi.",
              ),
            );
          }

          final materi = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: AppColors.primary
                            .withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.menu_book,
                        size: 35,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      materi.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Divider(),

                    const SizedBox(height: 20),

                    Text(
                      materi.body,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.7,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [

                          Icon(
                            Icons.lightbulb,
                            color: Colors.orange,
                          ),

                          SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              "Tips: Selesaikan materi ini sebelum mengerjakan quiz agar mendapatkan nilai maksimal.",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}