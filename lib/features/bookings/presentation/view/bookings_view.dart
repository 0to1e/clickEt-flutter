import 'package:flutter/material.dart';

/// A placeholder view for "My Bookings".
class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
      ),
      body: const Center(
        child: Text("Bookings Page - Under Development"),
      ),
    );
  }
}
