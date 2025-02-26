// lib/features/movie/presentation/view/movie_details_view.dart
import 'package:flutter/material.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';

class MovieDetailsView extends StatelessWidget {
  final MovieEntity movie;

  const MovieDetailsView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Large Poster
            Image.network(
              movie.posterLargeUrl,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            // Movie Details
            Row(
              children: [
                Image.network(
                  movie.posterSmallUrl,
                  width: 80,
                  height: 120,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Category: ${movie.category}'),
                      Text('Release: ${movie.releaseDate}'),
                      Text('Duration: ${movie.durationMin} minutes'),
                      Text('Language: ${movie.language}'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Description
            Text(
              'Description:\n${movie.description}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Schedule
            _ScheduleComponent(),
            const SizedBox(height: 16),
            // Cinema and Hall Selection
            _CinemaSelection(),
            _HallSelection(),
            const SizedBox(height: 16),
            // Book Seat Button
            ElevatedButton(
              onPressed: () {
                // Handle booking logic
              },
              child: const Text('Book Seat'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(7, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('Day ${index + 1}'),
          );
        }),
      ),
    );
  }
}

class _CinemaSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select cinema:'),
        DropdownButton<String>(
          items: ['Cinema 1', 'Cinema 2', 'Cinema 3']
              .map((cinema) => DropdownMenuItem(
                    value: cinema,
                    child: Text(cinema),
                  ))
              .toList(),
          onChanged: (value) {
            // Handle cinema selection
          },
        ),
      ],
    );
  }
}

class _HallSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select hall:'),
        DropdownButton<String>(
          items: ['Hall 1', 'Hall 2', 'Hall 3']
              .map((hall) => DropdownMenuItem(
                    value: hall,
                    child: Text(hall),
                  ))
              .toList(),
          onChanged: (value) {
            // Handle hall selection
          },
        ),
      ],
    );
  }
}
