import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    final auth = context.read<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(title: const Text("Profile")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 10),

            const CircleAvatar(
              radius: 55,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),

            const SizedBox(height: 20),

            Text(
              user?.displayName?.isNotEmpty == true
                  ? user!.displayName!
                  : "Pengguna QuizLearn",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              user?.email ?? "-",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 35),

            Card(
              elevation: 3,

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.person_outline,
                        color: AppColors.primary,
                      ),
                      title: const Text("Nama"),
                      subtitle: Text(
                        user?.displayName?.isNotEmpty == true
                            ? user!.displayName!
                            : "Pengguna QuizLearn",
                      ),
                    ),

                    const Divider(),

                    ListTile(
                      leading: const Icon(
                        Icons.email_outlined,
                        color: AppColors.primary,
                      ),
                      title: const Text("Email"),
                      subtitle: Text(user?.email ?? "-"),
                    ),

                    const Divider(),

                    const ListTile(
                      leading: Icon(Icons.verified_user, color: Colors.green),
                      title: Text("Status"),
                      subtitle: Text("Login"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),

                onPressed: () async {
                  await auth.logout();

                  if (!context.mounted) return;

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
