import 'package:flutter/material.dart';
import 'package:ClickEt/model/carousel_models.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double scale;
  final bool isFocused;

  const MovieCard({
    super.key,
    required this.movie,
    required this.scale,
    required this.isFocused,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 400,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              if (isFocused)
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 0),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              movie.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class MovieInfo extends StatelessWidget {
  final Movie movie;

  const MovieInfo({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          movie.category,
          style: textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          movie.title,
          style: textTheme.headlineLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              movie.rating,
              style: textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
