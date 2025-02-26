// movie_bloc.dart
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:ClickEt/features/movie/domain/use_case/get_showing_use_case.dart';
import 'package:ClickEt/features/movie/domain/use_case/get_upcoming_use_case.dart';
import 'package:ClickEt/features/movie/domain/use_case/cache_movies_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetShowingMoviesUseCase getShowingMoviesUseCase;
  final GetUpcomingMoviesUseCase getUpcomingMoviesUseCase;
  final CacheMoviesUseCase cacheMoviesUseCase;
  final Connectivity connectivity;

  MovieBloc({
    required this.getShowingMoviesUseCase,
    required this.getUpcomingMoviesUseCase,
    required this.cacheMoviesUseCase,
    required this.connectivity,
  }) : super(const MovieState()) {
    on<FetchAllMoviesEvent>(_onFetchAllMovies);
  }

  Future<void> _onFetchAllMovies(
    FetchAllMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final connectivityResult = await connectivity.checkConnectivity();
    final bool isConnected = connectivityResult != ConnectivityResult.none;

    if (isConnected) {
      try {
        final showingResult = await getShowingMoviesUseCase();
        final upcomingResult = await getUpcomingMoviesUseCase();

        if (showingResult.isLeft() || upcomingResult.isLeft()) {
          String? errorMessage;
          if (showingResult.isLeft()) {
            errorMessage = showingResult.fold(
              (failure) => failure.message, 
              (success) => null, 
            );
          }

          else if (upcomingResult.isLeft()) {
            errorMessage = upcomingResult.fold(
              (failure) => failure.message, 
              (success) => null, 
            );
          }
          emit(state.copyWith(
              isLoading: false, errorMessage: errorMessage ?? 'Unknown error'));
        } else {
          final showingMovies =
              showingResult.toOption().getOrElse(() => const []);
          final upcomingMovies =
              upcomingResult.toOption().getOrElse(() => const []);

          await cacheMoviesUseCase(
            CacheMoviesParams(movies: [...showingMovies, ...upcomingMovies]),
          );

          emit(
            state.copyWith(
              isLoading: false,
              showingMovies: showingMovies,
              upcomingMovies: upcomingMovies,
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Unexpected error: $e',
        ));
      }
    } else {
      try {
        final cachedShowing = await cacheMoviesUseCase.getCachedShowingMovies();
        final cachedUpcoming =
            await cacheMoviesUseCase.getCachedUpcomingMovies();

        if (cachedShowing.isEmpty && cachedUpcoming.isEmpty) {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: 'No internet and no cached movies',
          ));
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              showingMovies: cachedShowing,
              upcomingMovies: cachedUpcoming,
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Error retrieving cached movies: $e',
        ));
      }
    }
  }
}
