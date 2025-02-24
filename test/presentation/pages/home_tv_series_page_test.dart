import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/presentation/pages/home_tv_series_page.dart';
import 'package:ditonton/presentation/bloc/home_tv_series/home_tv_series_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockHomeTVSeriesBloc extends MockBloc<HomeTVSeriesEvent, HomeTVSeriesState>
    implements HomeTVSeriesBloc {}

void main() {
  late MockHomeTVSeriesBloc mockHomeTVSeriesBloc;

  setUp(() {
    mockHomeTVSeriesBloc = MockHomeTVSeriesBloc();
    locator.registerFactory<HomeTVSeriesBloc>(() => mockHomeTVSeriesBloc);
  });

  tearDown(() {
    locator.reset();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<HomeTVSeriesBloc>.value(
      value: mockHomeTVSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('HomeTvSeriesPage should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockHomeTVSeriesBloc.state).thenReturn(HomeTVSeriesInitial());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(HomeTvSeriesPage(
      scaffoldKey: GlobalKey<ScaffoldState>(),
    )));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('HomeTvSeriesPage should display error message when error',
      (WidgetTester tester) async {
    when(() => mockHomeTVSeriesBloc.state).thenReturn(HomeTVSeriesLoadedState(
      nowPlayingLoading: false,
      nowPlayingErrorMessage: 'Error',
      popularLoading: false,
      popularErrorMessage: 'Error',
      topRatedLoading: false,
      topRatedErrorMessage: 'Error',
    ));

    final errorMessageFinder = find.text('Error');

    await tester.pumpWidget(_makeTestableWidget(HomeTvSeriesPage(
      scaffoldKey: GlobalKey<ScaffoldState>(),
    )));

    expect(errorMessageFinder, findsWidgets);
  });

  testWidgets('HomeTvSeriesPage should display 3 list of TvSeries when loaded',
      (WidgetTester tester) async {
    when(() => mockHomeTVSeriesBloc.state).thenReturn(HomeTVSeriesLoadedState(
      nowPlayingLoading: false,
      nowPlayingErrorMessage: null,
      nowPlayingTvSeries: [
        tvSeries,
      ],
      popularLoading: false,
      popularErrorMessage: null,
      popularTvSeries: [
        tvSeries
      ],
      topRatedLoading: false,
      topRatedErrorMessage: null,
      topRatedTvSeries: [
        tvSeries
      ],
    ));

    final tvSeriesListFinder = find.byType(TvSeriesList);

    await tester.pumpWidget(_makeTestableWidget(HomeTvSeriesPage(
      scaffoldKey: GlobalKey<ScaffoldState>(),
    )));

    expect(tvSeriesListFinder, findsExactly(3));
  });
}