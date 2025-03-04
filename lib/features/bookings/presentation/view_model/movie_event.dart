// movie_event.dart
part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
  @override
  List<Object> get props => [];
}

class FetchAllMoviesEvent extends MovieEvent {
  const FetchAllMoviesEvent();

  @override
  List<Object> get props => [];
}

class RefreshMoviesEvent extends MovieEvent {
  const RefreshMoviesEvent();

  @override
  List<Object> get props => [];
}
