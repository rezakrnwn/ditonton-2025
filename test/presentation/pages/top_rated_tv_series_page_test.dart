import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedTVSeriesBloc
    extends MockBloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState>
    implements TopRatedTVSeriesBloc {}

void main() {
  late MockTopRatedTVSeriesBloc mockTopRatedTVSeriesBloc;

  setUp(() {
    mockTopRatedTVSeriesBloc = MockTopRatedTVSeriesBloc();
    locator.registerFactory<TopRatedTVSeriesBloc>(
      () => mockTopRatedTVSeriesBloc,
    );
  });

  tearDown(() {
    locator.reset();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVSeriesBloc>.value(
      value: mockTopRatedTVSeriesBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display progress bar when loading', (
    WidgetTester tester,
  ) async {
    when(
      () => mockTopRatedTVSeriesBloc.state,
    ).thenReturn(TopRatedTVSeriesInitial());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded', (
    WidgetTester tester,
  ) async {
    when(
      () => mockTopRatedTVSeriesBloc.state,
    ).thenReturn(TopRatedTVSeriesLoadedState(tvSeries: [tvSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (
    WidgetTester tester,
  ) async {
    when(
      () => mockTopRatedTVSeriesBloc.state,
    ).thenReturn(LoadTopRatedTVSeriesFailureState(message: 'Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
