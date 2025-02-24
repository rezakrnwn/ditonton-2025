import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/home_movie/home_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late HomeMovieBloc bloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = HomeMovieBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  blocTest<HomeMovieBloc, HomeMovieState>(
    'should emits loading state then loaded state when fetching movies succeeds',
    build: () {
      when(
        mockGetNowPlayingMovies.execute(),
      ).thenAnswer((_) async => Right(testMovieList));
      when(
        mockGetPopularMovies.execute(),
      ).thenAnswer((_) async => Right(testMovieList));
      when(
        mockGetTopRatedMovies.execute(),
      ).thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadHomeMovieEvent()),
    expect:
        () => [
          HomeMovieLoadedState(
            nowPlayingLoading: true,
            popularLoading: true,
            topRatedLoading: true,
          ),
          HomeMovieLoadedState(
            nowPlayingLoading: false,
            popularLoading: true,
            topRatedLoading: true,
            nowPlayingMovies: testMovieList,
          ),
          HomeMovieLoadedState(
            nowPlayingLoading: false,
            popularLoading: false,
            topRatedLoading: true,
            nowPlayingMovies: testMovieList,
            popularMovies: testMovieList,
          ),
          HomeMovieLoadedState(
            nowPlayingLoading: false,
            popularLoading: false,
            topRatedLoading: false,
            nowPlayingMovies: testMovieList,
            popularMovies: testMovieList,
            topRatedMovies: testMovieList,
          ),
        ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
      verify(mockGetPopularMovies.execute());
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<HomeMovieBloc, HomeMovieState>(
    'should emits error state when fetching movies fails',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Failed to load')));
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Failed to load')));
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Failed to load')));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadHomeMovieEvent()),
    expect: () => [
      HomeMovieLoadedState(
        nowPlayingLoading: true,
        popularLoading: true,
        topRatedLoading: true,
      ),
      HomeMovieLoadedState(
        nowPlayingLoading: false,
        popularLoading: true,
        topRatedLoading: true,
        nowPlayingErrorMessage: 'Failed to load',
      ),
      HomeMovieLoadedState(
        nowPlayingLoading: false,
        popularLoading: false,
        topRatedLoading: true,
        nowPlayingErrorMessage: 'Failed to load',
        popularErrorMessage: 'Failed to load',
      ),
      HomeMovieLoadedState(
        nowPlayingLoading: false,
        popularLoading: false,
        topRatedLoading: false,
        nowPlayingErrorMessage: 'Failed to load',
        popularErrorMessage: 'Failed to load',
        topRatedErrorMessage: 'Failed to load',
      ),
    ],
  );
}
