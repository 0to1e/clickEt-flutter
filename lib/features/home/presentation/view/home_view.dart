import 'package:ClickEt/common/carousel_widget.dart';
import 'package:ClickEt/features/movie/presentation/view_model/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// lib/features/home/presentation/view/home_view.dart
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(const FetchAllMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to ClickEt'),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage.isNotEmpty) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Now Showing Section
                  const Text(
                    'Now Showing',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  MovieCarousel(
                    movies: state.showingMovies,
                    viewportFraction: 0.8,
                    carouselHeight: 300,
                    minScale: 0.8,
                    scaleOffset: 0.2,
                  ),
                  const SizedBox(height: 16),

                  // Upcoming Section
                  const Text(
                    'Upcoming',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  MovieCarousel(
                    movies: state.upcomingMovies,
                    viewportFraction: 0.8,
                    carouselHeight: 300,
                    minScale: 0.8,
                    scaleOffset: 0.2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}