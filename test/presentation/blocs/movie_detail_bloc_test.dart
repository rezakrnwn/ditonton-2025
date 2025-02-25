import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getWatchListStatus: mockGetWatchlistStatus,
      getMovieRecommendations: mockGetMovieRecommendations,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    "should emit MovieDetailLoadedState(movieDetail: movieDetail, isAddedToWatchlist: true, movieRecommendations: [movie]) when data movie detail is gotten successfully",
    build: () {
      when(
        mockGetMovieDetail.execute(tId),
      ).thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
      when(
        mockGetMovieRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadMovieDetailEvent(id: tId)),
    expect:
        () => [
          MovieDetailLoadedState(movieDetail: testMovieDetail),
          MovieDetailLoadedState(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: true,
          ),
          MovieDetailLoadedState(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: true,
            movieRecommendations: tMovies,
          ),
        ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
      verify(mockGetWatchlistStatus.execute(tId));
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    "should emit LoadMovieDetailFailureState when data movie detail is gotten unsuccessfully",
    build: () {
      when(mockGetMovieDetail.execute(tId)).thenAnswer(
        (_) async =>
            Left(ConnectionFailure("Failed to connect to the network")),
      );
      when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
      when(
        mockGetMovieRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadMovieDetailEvent(id: tId)),
    expect:
        () => [
          LoadMovieDetailFailureState(
            message: "Failed to connect to the network",
          ),
        ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    "should emit MovieDetailLoadedState with movieRecommendationsErrorMessage when data movie recommendation is gotten unsuccessfully",
    build: () {
      when(
        mockGetMovieDetail.execute(tId),
      ).thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
      when(
        mockGetMovieRecommendations.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure("Failed")));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadMovieDetailEvent(id: tId)),
    expect:
        () => [
          MovieDetailLoadedState(movieDetail: testMovieDetail),
          MovieDetailLoadedState(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: true,
          ),
          MovieDetailLoadedState(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: true,
            movieRecommendationsErrorMessage: "Failed",
          ),
        ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
      verify(mockGetWatchlistStatus.execute(tId));
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    "should emit MovieDetailLoadedState with isAddedToWatchlist = false when detail movie is not listed on wishlist",
    build: () {
      when(
        mockGetMovieDetail.execute(tId),
      ).thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => false);
      when(
        mockGetMovieRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadMovieDetailEvent(id: tId)),
    expect:
        () => [
          MovieDetailLoadedState(movieDetail: testMovieDetail),
          MovieDetailLoadedState(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: false,
            movieRecommendations: tMovies,
          ),
        ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
      verify(mockGetWatchlistStatus.execute(tId));
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    "should emit MovieDetailLoadedState(isAddedToWatchlist: true, watchlistSuccessMessage: 'Added to Watchlist') when data is added to wishlist",
    build: () {
      when(
        mockSaveWatchlist.execute(testMovieDetail),
      ).thenAnswer((_) async => Right("Added to Watchlist"));

      bloc.emit(MovieDetailLoadedState(isAddedToWatchlist: false));
      return bloc;
    },
    act: (bloc) => bloc.add(AddMovieWatchlistEvent(movie: testMovieDetail)),
    expect:
        () => [
          MovieDetailLoadedState(
            isAddedToWatchlist: true,
            watchlistSuccessMessage: "Added to Watchlist",
          ),
        ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    "should emit MovieDetailLoadedState with watchlistErrorMessage when add data to wishlist is unsuccessfully",
    build: () {
      when(
        mockSaveWatchlist.execute(testMovieDetail),
      ).thenAnswer((_) async => Left(DatabaseFailure("Failed")));

      bloc.emit(MovieDetailLoadedState(isAddedToWatchlist: false));
      return bloc;
    },
    act: (bloc) => bloc.add(AddMovieWatchlistEvent(movie: testMovieDetail)),
    expect:
        () => [
          MovieDetailLoadedState(
            isAddedToWatchlist: false,
            watchlistErrorMessage: "Failed"
          ),
        ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    "should emit MovieDetailLoadedState(isAddedToWatchlist: false, watchlistSuccessMessage: 'Removed from Watchlist') when data is removed from wishlist",
    build: () {
      when(
        mockRemoveWatchlist.execute(testMovieDetail),
      ).thenAnswer((_) async => Right("Removed from Watchlist"));

      bloc.emit(MovieDetailLoadedState(isAddedToWatchlist: true));
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveMovieWatchlistEvent(movie: testMovieDetail)),
    expect:
        () => [
          MovieDetailLoadedState(
            isAddedToWatchlist: false,
            watchlistSuccessMessage: "Removed from Watchlist",
          ),
        ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    "should emit MovieDetailLoadedState with watchlistErrorMessage when remove data from wishlist is unsuccessfully",
    build: () {
      when(
        mockRemoveWatchlist.execute(testMovieDetail),
      ).thenAnswer((_) async => Left(DatabaseFailure("Failed")));

      bloc.emit(MovieDetailLoadedState(isAddedToWatchlist: true));
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveMovieWatchlistEvent(movie: testMovieDetail)),
    expect:
        () => [
          MovieDetailLoadedState(
            isAddedToWatchlist: true,
            watchlistErrorMessage: "Failed"
          ),
          MovieDetailLoadedState(
            isAddedToWatchlist: true,
            watchlistErrorMessage: ""
          ),
        ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}
