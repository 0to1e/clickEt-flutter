// import 'package:ClickEt/common/carousel_widget.dart';
// import 'package:ClickEt/model/carousel_models.dart';
// import 'package:flutter/material.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   static List<Movie> currentMoviesList = [
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

//   static List<Movie> upcomingMoviesList = [
//     Movie(
//       title: 'Deadpool 3',
//       rating: '9.0',
//       category: 'Action',
//       imageUrl:
//           'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_5.png',
//     ),
//     Movie(
//       title: 'Inside Out 2',
//       rating: '8.7',
//       category: 'Animation',
//       imageUrl:
//           'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_6.png',
//     ),
//     Movie(
//       title: 'Kung Fu Panda 4',
//       rating: '8.4',
//       category: 'Animation',
//       imageUrl:
//           'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_2.png',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:
//           Theme.of(context).scaffoldBackgroundColor, // Dark background
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         title: const Text('In theatres', style: TextStyle(color: Colors.black)),
//         actions: [
//           TextButton(
//             onPressed: () {},
//             child:
//                 const Text('See All >', style: TextStyle(color: Colors.grey)),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             MovieCarousel(movies: currentMoviesList),
//             MovieCarousel(movies: upcomingMoviesList),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:ClickEt/common/carousel_widget.dart';
import 'package:ClickEt/model/carousel_models.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static List<Movie> currentMoviesList = [
    Movie(
      title: 'Moana 2',
      rating: '8.9',
      category: 'Adventure',
      imageUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_2.png',
    ),
    Movie(
      title: 'Frozen 2',
      rating: '8.5',
      category: 'Animation',
      imageUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_3.png',
    ),
    Movie(
      title: 'Ford v Ferrari',
      rating: '8.3',
      category: 'Drama',
      imageUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_4.png',
    ),
  ];

  static List<Movie> upcomingMoviesList = [
    Movie(
      title: 'Deadpool 3',
      rating: '9.0',
      category: 'Action',
      imageUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_5.png',
    ),
    Movie(
      title: 'Inside Out 2',
      rating: '8.7',
      category: 'Animation',
      imageUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_6.png',
    ),
    Movie(
      title: 'Kung Fu Panda 4',
      rating: '8.4',
      category: 'Animation',
      imageUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_2.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'In theatres',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            MovieCarousel(
              movies: currentMoviesList,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            MovieCarousel(
              movies: upcomingMoviesList,
            ),
          ],
        ),
      ),
    );
  }
}
