// import 'package:flutter/material.dart';
// import 'package:ClickEt/model/carousel_models.dart';
// import 'package:ClickEt/common/movie_card.dart';
// import 'dart:math';

// class MovieCarousel extends StatefulWidget {
//   const MovieCarousel({super.key});

//   @override
//   State<MovieCarousel> createState() => _MovieCarouselState();
// }

// class _MovieCarouselState extends State<MovieCarousel> {
//   final PageController _controller = PageController(viewportFraction: 0.6);
//   double _currentPage = 0.0;

//   final List<Movie> movies = [
//     Movie(
//       title: 'Moana 2',
//       rating: '8.9',
//       category: 'Adventure',
//       imageUrl:
//           'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_2.png',
//     ),
//     Movie(
//       title: 'Frozen 2',
//       rating: '8.5',
//       category: 'Animation',
//       imageUrl:
//           'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_3.png',
//     ),
//     Movie(
//       title: 'Ford v Ferrari',
//       rating: '8.3',
//       category: 'Drama',
//       imageUrl:
//           'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_4.png',
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       setState(() {
//         _currentPage = _controller.page ?? 0.0;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 400, // Carousel height
//             child: PageView.builder(
//               controller: _controller,
//               itemCount: movies.length,
//               itemBuilder: (context, index) {
//                 final double scale =
//                     max(0.8, (1 - (_currentPage - index).abs()) + 0.2);
//                 final bool isFocused = (_currentPage.round() == index);
//                 return MovieCard(
//                     movie: movies[index], scale: scale, isFocused: isFocused);
//               },
//             ),
//           ),
//           // Focused poster movie info
//           MovieInfo(
//             movie: movies[_currentPage.round()],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ClickEt/model/carousel_models.dart';
import 'package:ClickEt/common/movie_card.dart';
import 'dart:math';

class MovieCarousel extends StatefulWidget {
  final List<Movie> movies;
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.carouselHeight,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              final double scale = max(widget.minScale,
                  (1 - (_currentPage - index).abs()) + widget.scaleOffset);
              final bool isFocused = (_currentPage.round() == index);

              return MovieCard(
                  movie: widget.movies[index],
                  scale: scale,
                  isFocused: isFocused);
            },
          ),
        ),
        MovieInfo(
          movie: widget.movies[_currentPage.round()],
        ),
      ],
    );
  }
}
