import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularMovieBloc extends MockBloc<PopularMovieEvent, PopularMovieState> implements PopularMovieBloc {}

void main() {
  late MockPopularMovieBloc mockPopularMovieBloc;

  setUp(() {
    mockPopularMovieBloc = MockPopularMovieBloc();
    locator.registerFactory<PopularMovieBloc>(() => mockPopularMovieBloc);
  });

  tearDown(() {
    locator.reset();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>.value(
      value: mockPopularMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state).thenReturn(PopularMovieInitial());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state).thenReturn(PopularMovieLoadedState(
      movies: [testMovie],
    ));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state).thenReturn(LoadPopularMovieFailureState(message: 'Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
