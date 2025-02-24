import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvSeriesDetailBloc
    extends MockBloc<TVSeriesDetailEvent, TVSeriesDetailState>
    implements TvSeriesDetailBloc {}

void main() {
  late MockTvSeriesDetailBloc mockTvSeriesDetailBloc;

  setUp(() {
    mockTvSeriesDetailBloc = MockTvSeriesDetailBloc();
    locator.registerFactory<TvSeriesDetailBloc>(() => mockTvSeriesDetailBloc);
  });

  tearDown(() {
    locator.reset();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesDetailBloc>.value(
      value: mockTvSeriesDetailBloc,
      child: MaterialApp(home: Scaffold(body: body)),
    );
  }

  testWidgets(
    'Watchlist button should display add icon when TV Series not added to watchlist',
    (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state).thenReturn(
        TVSeriesDetailLoadedState(
          tvSeriesDetail: testTVSeriesDetail,
          tvSeriesRecommendations: [tvSeries],
          isAddedToWatchlist: false,
        ),
      );

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should dispay check icon when TV Series is added to wathclist',
    (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state).thenReturn(
        TVSeriesDetailLoadedState(
          tvSeriesDetail: testTVSeriesDetail,
          tvSeriesRecommendations: [tvSeries],
          isAddedToWatchlist: true,
        ),
      );

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display Snackbar when added to watchlist',
    (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state).thenReturn(
        TVSeriesDetailLoadedState(
          tvSeriesDetail: testTVSeriesDetail,
          tvSeriesRecommendations: [tvSeries],
          isAddedToWatchlist: false,
        ),
      );
      whenListen(
        mockTvSeriesDetailBloc,
        Stream.fromIterable([
          TVSeriesDetailLoadedState(
            tvSeriesDetail: testTVSeriesDetail,
            tvSeriesRecommendations: [tvSeries],
            isAddedToWatchlist: false,
          ),
          TVSeriesDetailLoadedState(
            tvSeriesDetail: testTVSeriesDetail,
            tvSeriesRecommendations: [tvSeries],
            isAddedToWatchlist: true,
            watchlistSuccessMessage: 'Added to Watchlist',
          ),
        ]),
      );

      final watchlistButton = find.byType(FilledButton);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display AlertDialog when add to watchlist failed',
    (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state).thenReturn(
        TVSeriesDetailLoadedState(
          tvSeriesDetail: testTVSeriesDetail,
          tvSeriesRecommendations: [tvSeries],
          isAddedToWatchlist: false,
        ),
      );
      whenListen(
        mockTvSeriesDetailBloc,
        Stream.fromIterable([
          TVSeriesDetailLoadedState(
            tvSeriesDetail: testTVSeriesDetail,
            tvSeriesRecommendations: [tvSeries],
            isAddedToWatchlist: false,
          ),
          TVSeriesDetailLoadedState(
            tvSeriesDetail: testTVSeriesDetail,
            tvSeriesRecommendations: [tvSeries],
            isAddedToWatchlist: false,
            watchlistErrorMessage: 'Failed',
          ),
        ]),
      );

      final watchlistButton = find.byType(FilledButton);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton, warnIfMissed: false);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    },
  );
}
