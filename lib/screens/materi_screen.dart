import 'package:flutter/material.dart';

import '../models/materi_model.dart';
import '../services/api_service.dart';
import '../utils/app_colors.dart';
import 'detail_materi_screen.dart';

class MateriScreen extends StatefulWidget {
  const MateriScreen({super.key});

  @override
  State<MateriScreen> createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  late Future<List<MateriModel>> _materi;

  @override
  void initState() {
    super.initState();
    _materi = ApiService.getMateri();
  }

  Future<void> _refresh() async {
    setState(() {
      _materi = ApiService.getMateri();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(title: const Text("Materi")),

      body: RefreshIndicator(
        onRefresh: _refresh,

        child: FutureBuilder<List<MateriModel>>(
          future: _materi,

          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off, size: 70, color: Colors.grey),

                      const SizedBox(height: 20),

                      const Text(
                        "Gagal mengambil data",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: _refresh,
                        child: const Text("Coba Lagi"),
                      ),
                    ],
                  ),
                ),
              );
            }

            final materi = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(16),

              itemCount: materi.length,

              itemBuilder: (context, index) {
                final item = materi[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),

                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailMateriScreen(materiId: item.id),
                        ),
                      );
                    },

                    child: Padding(
                      padding: const EdgeInsets.all(18),

                      child: Row(
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.menu_book,
                              color: AppColors.primary,
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  item.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  item.body,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          const Icon(Icons.arrow_forward_ios, size: 18),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
