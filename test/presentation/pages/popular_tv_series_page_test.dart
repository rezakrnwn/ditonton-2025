import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularTVSeriesBloc
    extends MockBloc<PopularTVSeriesEvent, PopularTVSeriesState>
    implements PopularTVSeriesBloc {}

void main() {
  late MockPopularTVSeriesBloc mockPopularTVSeriesBloc;

  setUp(() {
    mockPopularTVSeriesBloc = MockPopularTVSeriesBloc();
    locator.registerFactory<PopularTVSeriesBloc>(() => mockPopularTVSeriesBloc);
  });

  tearDown(() {
    locator.reset();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTVSeriesBloc>.value(
      value: mockPopularTVSeriesBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading', (
    WidgetTester tester,
  ) async {
    when(
      () => mockPopularTVSeriesBloc.state,
    ).thenReturn(PopularTVSeriesInitial());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (
    WidgetTester tester,
  ) async {
    when(
      () => mockPopularTVSeriesBloc.state,
    ).thenReturn(PopularTVSeriesLoadedState(tvSeries: [tvSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (
    WidgetTester tester,
  ) async {
    when(
      () => mockPopularTVSeriesBloc.state,
    ).thenReturn(LoadPopularTVSeriesFailureState(message: 'Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
