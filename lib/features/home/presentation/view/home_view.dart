import 'package:ClickEt/common/widgets/carousel_widget.dart';
import 'package:ClickEt/features/movie/presentation/view_model/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Welcome to ClickEt',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Now Showing',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  MovieCarousel(
                    movies: state.showingMovies,
                    viewportFraction: 0.8,
                    carouselHeight: 240,
                    minScale: 0.8,
                    scaleOffset: 0.2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Upcoming Section
                  Text('Upcoming',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 12), // Reduced gap
                  MovieCarousel(
                    movies: state.upcomingMovies,
                    viewportFraction: 0.8,
                    carouselHeight: 270,
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
