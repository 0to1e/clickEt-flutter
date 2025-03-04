// import 'package:flutter/material.dart';
// import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';

// class MovieCard extends StatelessWidget {
//   final MovieEntity movie;
//   final double scale;
//   final bool isFocused;

//   const MovieCard({
//     super.key,
//     required this.movie,
//     required this.scale,
//     required this.isFocused,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Transform.scale(
//         scale: scale,
//         child: Container(
//           width: 400,
//           margin: const EdgeInsets.symmetric(horizontal: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             boxShadow: [
//               if (isFocused)
//                 BoxShadow(
//                   color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
//                   blurRadius: 15,
//                   spreadRadius: 2,
//                   offset: const Offset(0, 0),
//                 ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(5),
//             child: Image.network(
//               movie.posterLargeUrl,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;
  final double scale;
  final bool isFocused;
  final VoidCallback? onTap;

  const MovieCard({
    super.key,
    required this.movie,
    required this.scale,
    required this.isFocused,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: scale,
        child: GestureDetector(
          onTap: onTap,
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
                movie.posterLargeUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}