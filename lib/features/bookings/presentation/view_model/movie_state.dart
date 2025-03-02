// movie_state.dart
part of 'movie_bloc.dart';

class MovieState extends Equatable {
  final List<MovieEntity> showingMovies;
  final List<MovieEntity> upcomingMovies;
  final bool isLoading;
  final String errorMessage;

  const MovieState({
    this.showingMovies = const [],
    this.upcomingMovies = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  MovieState copyWith({
    List<MovieEntity>? showingMovies,
    List<MovieEntity>? upcomingMovies,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MovieState(
      showingMovies: showingMovies ?? this.showingMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [showingMovies, upcomingMovies, isLoading, errorMessage];
}
