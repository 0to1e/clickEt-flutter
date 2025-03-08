import 'package:ClickEt/features/home/presentation/view/home_view.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:ClickEt/features/movie/domain/use_case/cache_movies_use_case.dart';
import 'package:ClickEt/features/movie/domain/use_case/get_showing_use_case.dart';
import 'package:ClickEt/features/movie/domain/use_case/get_upcoming_use_case.dart';
import 'package:ClickEt/features/movie/presentation/view_model/movie_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockMovieBloc extends Mock implements MovieBloc {}
class MockGetShowingMoviesUseCase extends Mock implements GetShowingMoviesUseCase {}
class MockGetUpcomingMoviesUseCase extends Mock implements GetUpcomingMoviesUseCase {}
class MockCacheMoviesUseCase extends Mock implements CacheMoviesUseCase {}
class MockConnectivity extends Mock implements Connectivity {}
class FakeMovieEvent extends Fake implements MovieEvent {}

// Helper function to create a MovieEntity instance
MovieEntity createMovieEntity({
  required String id,
  required String name,
}) {
  return MovieEntity(
    id: id,
    name: name,
    category: 'Action',
    description: 'A thrilling movie',
    releaseDate: '2023-01-01',
    durationMin: 120,
    language: 'English',
    posterSmallUrl: 'small_url',
    posterLargeUrl: 'large_url',
    trailerUrl: 'trailer_url',
    status: 'Released',
  );
}

void main() {
  late MockMovieBloc mockMovieBloc;
  late MockGetShowingMoviesUseCase mockGetShowingMoviesUseCase;
  late MockGetUpcomingMoviesUseCase mockGetUpcomingMoviesUseCase;
  late MockCacheMoviesUseCase mockCacheMoviesUseCase;
  late MockConnectivity mockConnectivity;

  setUpAll(() {
    registerFallbackValue(FakeMovieEvent());
    registerFallbackValue(const CacheMoviesParams(movies: []));
  });

  setUp(() {
    mockMovieBloc = MockMovieBloc();
    mockGetShowingMoviesUseCase = MockGetShowingMoviesUseCase();
    mockGetUpcomingMoviesUseCase = MockGetUpcomingMoviesUseCase();
    mockCacheMoviesUseCase = MockCacheMoviesUseCase();
    mockConnectivity = MockConnectivity();

    when(() => mockMovieBloc.stream).thenAnswer((_) => Stream.value(const MovieState()));
    when(() => mockMovieBloc.state).thenReturn(const MovieState());
    when(() => mockMovieBloc.close()).thenAnswer((_) async {});
  });

  tearDown(() {
    mockMovieBloc.close();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<MovieBloc>.value(
        value: mockMovieBloc,
        child: const HomeView(),
      ),
    );
  }

  group('HomeView', () {
testWidgets('renders app bar with title', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // Pump once to render initial frame

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Welcome to ClickEt'), findsOneWidget);
    });

    testWidgets('shows loading indicator when state is loading', (tester) async {
      when(() => mockMovieBloc.state).thenReturn(
        const MovieState(isLoading: true),
      );
      when(() => mockMovieBloc.stream).thenAnswer((_) => Stream.value(
            const MovieState(isLoading: true),
          ));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message when there is an error', (tester) async {
      const errorMessage = 'Failed to fetch movies';
      when(() => mockMovieBloc.state).thenReturn(
        const MovieState(errorMessage: errorMessage),
      );
      when(() => mockMovieBloc.stream).thenAnswer((_) => Stream.value(
            const MovieState(errorMessage: errorMessage),
          ));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Error: $errorMessage'), findsOneWidget);
    });

    testWidgets('triggers FetchAllMoviesEvent on initialization', (tester) async {
      when(() => mockMovieBloc.add(any())).thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      verify(() => mockMovieBloc.add(const FetchAllMoviesEvent())).called(1);
    });


    testWidgets('shows error when offline and no cached movies', (tester) async {
      final bloc = MovieBloc(
        getShowingMoviesUseCase: mockGetShowingMoviesUseCase,
        getUpcomingMoviesUseCase: mockGetUpcomingMoviesUseCase,
        cacheMoviesUseCase: mockCacheMoviesUseCase,
        connectivity: mockConnectivity,
      );

      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);
      when(() => mockCacheMoviesUseCase.getCachedShowingMovies())
          .thenAnswer((_) async => []);
      when(() => mockCacheMoviesUseCase.getCachedUpcomingMovies())
          .thenAnswer((_) async => []);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MovieBloc>.value(
            value: bloc,
            child: const HomeView(),
          ),
        ),
      );
      await tester.pump(); // Trigger initState
      await tester.pumpAndSettle(); // Wait for async operations

      expect(find.text('Error: No internet and no cached movies'), findsOneWidget);
    });
  });
}