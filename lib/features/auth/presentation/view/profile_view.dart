import 'package:flutter/material.dart';

/// The "Me" view includes a logout button and a profile image placeholder.
class MeView extends StatelessWidget {
  const MeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Me"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace this asset with your actual profile image or network image.
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("lib/assets/profile_placeholder.png"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Temporary logout action; you can integrate your logout logic later.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logged out")),
                );
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
