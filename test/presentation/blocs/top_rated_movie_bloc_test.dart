import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc bloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = TopRatedMovieBloc(getTopRatedMovies: mockGetTopRatedMovies);
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'should emit [TopRatedMovieInitial, TopRatedMovieLoadedState] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right([testMovie]));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTopRatedMovieEvent()),
      expect: () => [
            TopRatedMovieInitial(),
            TopRatedMovieLoadedState(
              movies: [testMovie]
            ),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      "should emit [TopRatedMovieInitial, LoadTopRatedMovieFailureState] when get data is unsuccessful",
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTopRatedMovieEvent()),
      expect: () => [
            TopRatedMovieInitial(),
            LoadTopRatedMovieFailureState(message: 'Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });
}
