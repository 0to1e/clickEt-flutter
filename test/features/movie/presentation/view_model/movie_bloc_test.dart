import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/movie/presentation/view_model/movie_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:ClickEt/features/movie/domain/use_case/cache_movies_use_case.dart';
import 'package:ClickEt/features/movie/domain/use_case/get_showing_use_case.dart';
import 'package:ClickEt/features/movie/domain/use_case/get_upcoming_use_case.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetShowingMoviesUseCase extends Mock
    implements GetShowingMoviesUseCase {}

class MockGetUpcomingMoviesUseCase extends Mock
    implements GetUpcomingMoviesUseCase {}

class MockCacheMoviesUseCase extends Mock implements CacheMoviesUseCase {}

class MockConnectivity extends Mock implements Connectivity {}

class MockFailure extends Mock implements Failure {}

void main() {
  late MovieBloc movieBloc;
  late MockGetShowingMoviesUseCase mockGetShowingMoviesUseCase;
  late MockGetUpcomingMoviesUseCase mockGetUpcomingMoviesUseCase;
  late MockCacheMoviesUseCase mockCacheMoviesUseCase;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockGetShowingMoviesUseCase = MockGetShowingMoviesUseCase();
    mockGetUpcomingMoviesUseCase = MockGetUpcomingMoviesUseCase();
    mockCacheMoviesUseCase = MockCacheMoviesUseCase();
    mockConnectivity = MockConnectivity();

    movieBloc = MovieBloc(
      getShowingMoviesUseCase: mockGetShowingMoviesUseCase,
      getUpcomingMoviesUseCase: mockGetUpcomingMoviesUseCase,
      cacheMoviesUseCase: mockCacheMoviesUseCase,
      connectivity: mockConnectivity,
    );

    registerFallbackValue(const CacheMoviesParams(movies: []));
  });

  tearDown(() {
    movieBloc.close();
  });

  // Helper method to create mock MovieEntity
  MovieEntity createMockMovie(String id, String name, String status) {
    return MovieEntity(
      id: id,
      name: name,
      category: 'Action',
      description: 'A test movie description',
      releaseDate: '2025-03-05',
      durationMin: 120,
      language: 'English',
      posterSmallUrl: 'http://example.com/poster_small.jpg',
      posterLargeUrl: 'http://example.com/poster_large.jpg',
      trailerUrl: 'http://example.com/trailer.mp4',
      status: status,
    );
  }

  group('FetchAllMoviesEvent', () {
    final mockShowingMovies = [
      createMockMovie('1', 'Showing Movie 1', 'showing'),
    ];
    final mockUpcomingMovies = [
      createMockMovie('2', 'Upcoming Movie 1', 'upcoming'),
    ];

    blocTest<MovieBloc, MovieState>(
      'emits loading and success states when online fetch is successful',
      build: () {
        when(() => mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => [ConnectivityResult.wifi]);
        when(() => mockGetShowingMoviesUseCase())
            .thenAnswer((_) async => Right(mockShowingMovies));
        when(() => mockGetUpcomingMoviesUseCase())
            .thenAnswer((_) async => Right(mockUpcomingMovies));
        when(() => mockCacheMoviesUseCase(any()))
            .thenAnswer((_) async => const Right(unit));
        return movieBloc;
      },
      act: (bloc) => bloc.add(const FetchAllMoviesEvent()),
      expect: () => [
        const MovieState(isLoading: true, errorMessage: ''),
        MovieState(
          isLoading: false,
          showingMovies: mockShowingMovies,
          upcomingMovies: mockUpcomingMovies,
        ),
      ],
      verify: (_) {
        verify(() => mockCacheMoviesUseCase(any())).called(1);
      },
    );

    blocTest<MovieBloc, MovieState>(
      'emits loading and cached movies when offline with cached data',
      build: () {
        when(() => mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => [ConnectivityResult.none]);
        when(() => mockCacheMoviesUseCase.getCachedShowingMovies())
            .thenAnswer((_) async => mockShowingMovies);
        when(() => mockCacheMoviesUseCase.getCachedUpcomingMovies())
            .thenAnswer((_) async => mockUpcomingMovies);
        return movieBloc;
      },
      act: (bloc) => bloc.add(const FetchAllMoviesEvent()),
      expect: () => [
        const MovieState(isLoading: true, errorMessage: ''),
        MovieState(
          isLoading: false,
          showingMovies: mockShowingMovies,
          upcomingMovies: mockUpcomingMovies,
        ),
      ],
    );

    blocTest<MovieBloc, MovieState>(
      'emits loading and error when offline with no cached data',
      build: () {
        when(() => mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => [ConnectivityResult.none]);
        when(() => mockCacheMoviesUseCase.getCachedShowingMovies())
            .thenAnswer((_) async => []);
        when(() => mockCacheMoviesUseCase.getCachedUpcomingMovies())
            .thenAnswer((_) async => []);
        return movieBloc;
      },
      act: (bloc) => bloc.add(const FetchAllMoviesEvent()),
      expect: () => [
        const MovieState(isLoading: true, errorMessage: ''),
        const MovieState(
          isLoading: false,
          errorMessage: 'No internet and no cached movies',
        ),
      ],
    );
  });

  group('RefreshMoviesEvent', () {
    final mockShowingMovies = [
      createMockMovie('1', 'Showing Movie 1', 'showing'),
    ];
    final mockUpcomingMovies = [
      createMockMovie('2', 'Upcoming Movie 1', 'upcoming'),
    ];

    blocTest<MovieBloc, MovieState>(
      'emits loading and success states when refresh is successful',
      build: () {
        when(() => mockGetShowingMoviesUseCase())
            .thenAnswer((_) async => Right(mockShowingMovies));
        when(() => mockGetUpcomingMoviesUseCase())
            .thenAnswer((_) async => Right(mockUpcomingMovies));
        return movieBloc;
      },
      act: (bloc) => bloc.add(const RefreshMoviesEvent()),
      expect: () => [
        const MovieState(isLoading: true),
        MovieState(
          isLoading: false,
          showingMovies: mockShowingMovies,
          upcomingMovies: mockUpcomingMovies,
        ),
      ],
    );

    blocTest<MovieBloc, MovieState>(
      'emits loading and error states when refresh fails',
      build: () {
        when(() => mockGetShowingMoviesUseCase())
            .thenAnswer((_) async => Left(MockFailure()));
        when(() => mockGetUpcomingMoviesUseCase())
            .thenAnswer((_) async => Right(mockUpcomingMovies));
        return movieBloc;
      },
      act: (bloc) => bloc.add(const RefreshMoviesEvent()),
      expect: () => [
        const MovieState(isLoading: true),
        const MovieState(
          isLoading: false,
          errorMessage: 'Failed to refresh movies',
        ),
      ],
    );
  });
}
