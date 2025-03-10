import 'package:ClickEt/common/widgets/movie_details_view.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:ClickEt/common/widgets/movie_card.dart';

class MovieCarousel extends StatefulWidget {
  final List<MovieEntity> movies;
  final double viewportFraction;
  final double carouselHeight;
  final double minScale;
  final double scaleOffset;

  const MovieCarousel({
    super.key,
    required this.movies,
    this.viewportFraction = 0.6,
    this.carouselHeight = 400,
    this.minScale = 0.8,
    this.scaleOffset = 0.2,
  });

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  late final PageController _controller;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: widget.viewportFraction);
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.carouselHeight,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              final double scale = max(
                widget.minScale,
                (1 - (_currentPage - index).abs()) + widget.scaleOffset,
              );
              final bool isFocused = (_currentPage.round() == index);

              return MovieCard(
                movie: widget.movies[index],
                scale: scale,
                isFocused: isFocused,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsView(
                        movie: widget.movies[index],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Text(
          widget.movies[_currentPage.round()].name,
          style: TextStyle(
              fontSize: 25,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
