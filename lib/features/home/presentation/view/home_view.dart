// import 'package:ClickEt/features/movie/presentation/view_model/movie_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   @override
//   void initState() {
//     super.initState();
//     // Dispatch the FetchAllMoviesEvent when the page loads
//     context.read<MovieBloc>().add(const FetchAllMoviesEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Welcome to ClickEt'),
//       ),
//       // Use BlocBuilder to rebuild whenever MovieState changes
//       body: BlocBuilder<MovieBloc, MovieState>(
//         builder: (context, state) {
//           // 1) Display loading indicator
//           if (state.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           // 2) Display an error if something went wrong
//           if (state.errorMessage.isNotEmpty) {
//             return Center(child: Text('Error: ${state.errorMessage}'));
//           }

//           // 3) Otherwise, show the fetched movies
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Now Showing
//                   const Text(
//                     'Now Showing',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   ListView.builder(
//                     // So the ListView doesn’t scroll independently
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: state.showingMovies.length,
//                     itemBuilder: (context, index) {
//                       final movie = state.showingMovies[index];
//                       return ListTile(
//                         leading: Image.network(movie.posterSmallUrl),
//                         title: Text(movie.name),
//                         subtitle: Text(movie.description),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 16),

//                   // Upcoming
//                   const Text(
//                     'Upcoming',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   ListView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: state.upcomingMovies.length,
//                     itemBuilder: (context, index) {
//                       final movie = state.upcomingMovies[index];
//                       return ListTile(
//                         leading: Image.network(movie.posterSmallUrl),
//                         title: Text(movie.name),
//                         subtitle: Text(movie.description),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }












import 'package:ClickEt/common/carousel_widget.dart';
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