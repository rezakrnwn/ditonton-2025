import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    locator.registerFactory<MovieDetailBloc>(() => mockMovieDetailBloc);
  });

  tearDown(() {
    locator.reset();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockMovieDetailBloc,
      child: MaterialApp(home: Scaffold(body: body)),
    );
  }

  testWidgets(
    'Watchlist button should display add icon when movie not added to watchlist',
    (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(
        MovieDetailLoadedState(
          movieDetail: testMovieDetail,
          movieRecommendations: [testMovie],
          isAddedToWatchlist: false,
        ),
      );

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should dispay check icon when movie is added to wathclist',
    (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(
        MovieDetailLoadedState(
          movieDetail: testMovieDetail,
          movieRecommendations: [testMovie],
          isAddedToWatchlist: true,
        ),
      );

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display Snackbar when added to watchlist',
    (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(
        MovieDetailLoadedState(
          movieDetail: testMovieDetail,
          movieRecommendations: [testMovie],
          isAddedToWatchlist: false,
        ),
      );
      whenListen(
        mockMovieDetailBloc,
        Stream.fromIterable([
          MovieDetailLoadedState(
            movieDetail: testMovieDetail,
            movieRecommendations: [testMovie],
            isAddedToWatchlist: false,
          ),
          MovieDetailLoadedState(
            movieDetail: testMovieDetail,
            movieRecommendations: [testMovie],
            isAddedToWatchlist: true,
            watchlistSuccessMessage: 'Added to Watchlist',
          ),
        ]),
      );

      final watchlistButton = find.byType(FilledButton);
      final watchlistIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(watchlistIcon, findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display AlertDialog when add to watchlist failed',
    (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(
        MovieDetailLoadedState(
          movieDetail: testMovieDetail,
          movieRecommendations: [testMovie],
          isAddedToWatchlist: false,
        ),
      );
      whenListen(
        mockMovieDetailBloc,
        Stream.fromIterable([
          MovieDetailLoadedState(
            movieDetail: testMovieDetail,
            movieRecommendations: [testMovie],
            isAddedToWatchlist: false,
          ),
          MovieDetailLoadedState(
            movieDetail: testMovieDetail,
            movieRecommendations: [testMovie],
            isAddedToWatchlist: false,
            watchlistErrorMessage: 'Failed',
          ),
        ]),
      );

      final watchlistButton = find.byType(FilledButton);
      final watchlistIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(watchlistIcon, findsOneWidget);

      await tester.tap(watchlistButton, warnIfMissed: false);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    },
  );
}
