import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/home_movie/home_movie_bloc.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockHomeMovieBloc extends MockBloc<HomeMovieEvent, HomeMovieState>
    implements HomeMovieBloc {}

void main() {
  late MockHomeMovieBloc mockHomeMovieBloc;

  setUp(() {
    mockHomeMovieBloc = MockHomeMovieBloc();
    locator.registerFactory<HomeMovieBloc>(() => mockHomeMovieBloc);
  });

  tearDown(() {
    locator.reset();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<HomeMovieBloc>.value(
      value: mockHomeMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Displays loading indicator when loading movies', (
    WidgetTester tester,
  ) async {
    when(() => mockHomeMovieBloc.state).thenReturn(
      HomeMovieLoadedState(
        nowPlayingLoading: true,
        popularLoading: true,
        topRatedLoading: true,
      ),
    );

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeMoviePage(scaffoldKey: GlobalKey<ScaffoldState>())
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('Displays movie list when movies are loaded', (
    WidgetTester tester,
  ) async {
    when(() => mockHomeMovieBloc.state).thenReturn(
      HomeMovieLoadedState(
        nowPlayingLoading: false,
        popularLoading: false,
        topRatedLoading: false,
        nowPlayingMovies: [testMovie],
        popularMovies: [testMovie],
        topRatedMovies: [testMovie],
      ),
    );

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeMoviePage(scaffoldKey: GlobalKey<ScaffoldState>())
      ),
    );

    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
  });

  testWidgets('Displays error message when loading fails', (
    WidgetTester tester,
  ) async {
    when(() => mockHomeMovieBloc.state).thenReturn(
      HomeMovieLoadedState(
        nowPlayingLoading: false,
        popularLoading: false,
        topRatedLoading: false,
        nowPlayingErrorMessage: 'Error loading movies',
      ),
    );

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeMoviePage(scaffoldKey: GlobalKey<ScaffoldState>())
      ),
    );

    expect(find.text('Error loading movies'), findsOneWidget);
  });
}
