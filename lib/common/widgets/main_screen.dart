import 'package:ClickEt/common/bottom_navigation_bar/bottom_navigation_cubit.dart';
import 'package:ClickEt/features/auth/presentation/view/profile_view.dart';
import 'package:ClickEt/features/bookings/presentation/view/bookings_view.dart';
import 'package:ClickEt/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavigationCubit(),
      child: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, currentIndex) {
          // Select the page based on the current index.
          Widget body;
          switch (currentIndex) {
            case 0:
              body = const HomeView();
              break;
            case 1:
              body = const BookingsView();
              break;
            case 2:
              body = const ProfileView();
              break;
            default:
              body = const HomeView();
          }
          return Scaffold(
            body: body,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<BottomNavigationCubit>().updateIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: "My Bookings",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Me",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
