import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'materi_screen.dart';
import '../providers/auth_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../widgets/feature_card.dart';
import 'history_screen.dart';
import 'quiz_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("QuizLearn"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text("Halo 👋", style: TextStyle(fontSize: 18)),

            const SizedBox(height: 6),

            const Text(
              "Selamat Datang di QuizLearn",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,

              children: [
                FeatureCard(
                  icon: Icons.menu_book,
                  title: "Materi",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MateriScreen()),
                    );
                  },
                ),

                FeatureCard(
                  icon: Icons.quiz,
                  title: "Quiz",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const QuizScreen()),
                    );
                  },
                ),

                FeatureCard(
                  icon: Icons.history,
                  title: "History",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HistoryScreen()),
                    );
                  },
                ),

                FeatureCard(
                  icon: Icons.person,
                  title: "Profile",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 35),

            const Text(
              "Progress Belajar",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const SizedBox(height: 15),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const LinearProgressIndicator(minHeight: 12, value: 0.4),
            ),

            const SizedBox(height: 8),

            const Align(alignment: Alignment.centerRight, child: Text("40%")),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                onPressed: () async {
                  await auth.logout();

                  if (!context.mounted) return;

                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
