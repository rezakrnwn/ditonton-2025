import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTVSeriesDetail,
  GetTVSeriesRecommendations,
  GetWatchListStatusTVSeries,
  SaveWatchlistTVSeries,
  RemoveWatchlistTVSeries,
])
void main() {
  late TvSeriesDetailBloc bloc;
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendations;
  late MockGetWatchListStatusTVSeries mockGetWatchListStatusTVSeries;
  late MockSaveWatchlistTVSeries mockSaveWatchlist;
  late MockRemoveWatchlistTVSeries mockRemoveWatchlist;

  final tId = 1;

  setUp(() {
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    mockGetTVSeriesRecommendations = MockGetTVSeriesRecommendations();
    mockGetWatchListStatusTVSeries = MockGetWatchListStatusTVSeries();
    mockSaveWatchlist = MockSaveWatchlistTVSeries();
    mockRemoveWatchlist = MockRemoveWatchlistTVSeries();
    bloc = TvSeriesDetailBloc(
      getTVSeriesDetail: mockGetTVSeriesDetail,
      getWatchListStatusTVSeries: mockGetWatchListStatusTVSeries,
      getTVSeriesRecommendations: mockGetTVSeriesRecommendations,
      saveWatchlistTVSeries: mockSaveWatchlist,
      removeWatchlistTVSeries: mockRemoveWatchlist,
    );
  });

  blocTest<TvSeriesDetailBloc, TVSeriesDetailState>(
    "should emit TVSeriesDetailLoadedState when data tv series detail is gotten successfully",
    build: () {
      when(
        mockGetTVSeriesDetail.execute(tId),
      ).thenAnswer((_) async => Right(testTVSeriesDetail));
      when(
        mockGetWatchListStatusTVSeries.execute(tId),
      ).thenAnswer((_) async => true);
      when(
        mockGetTVSeriesRecommendations.execute(tId),
      ).thenAnswer((_) async => Right([tvSeries]));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTVSeriesDetailEvent(id: tId)),
    expect:
        () => [
          TVSeriesDetailLoadedState(tvSeriesDetail: testTVSeriesDetail),
          TVSeriesDetailLoadedState(
            tvSeriesDetail: testTVSeriesDetail,
            isAddedToWatchlist: true,
          ),
          TVSeriesDetailLoadedState(
            tvSeriesDetail: testTVSeriesDetail,
            isAddedToWatchlist: true,
            tvSeriesRecommendations: [tvSeries],
          ),
        ],
    verify: (bloc) {
      verify(mockGetTVSeriesDetail.execute(tId));
      verify(mockGetWatchListStatusTVSeries.execute(tId));
      verify(mockGetTVSeriesRecommendations.execute(tId));
    },
  );

  blocTest<TvSeriesDetailBloc, TVSeriesDetailState>(
    "should emit LoadTVSeriesDetailFailureState when data tv series detail is gotten unsuccessfully",
    build: () {
      when(mockGetTVSeriesDetail.execute(tId)).thenAnswer(
        (_) async =>
            Left(ConnectionFailure("Failed to connect to the network")),
      );
      when(
        mockGetWatchListStatusTVSeries.execute(tId),
      ).thenAnswer((_) async => true);
      when(
        mockGetTVSeriesRecommendations.execute(tId),
      ).thenAnswer((_) async => Right([tvSeries]));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTVSeriesDetailEvent(id: tId)),
    expect:
        () => [
          LoadTVSeriesDetailFailureState(
            message: "Failed to connect to the network",
          ),
        ],
    verify: (bloc) {
      verify(mockGetTVSeriesDetail.execute(tId));
    },
  );

  blocTest<TvSeriesDetailBloc, TVSeriesDetailState>(
    "should emit TVSeriesDetailLoadedState when data is added to wishlist",
    build: () {
      when(
        mockSaveWatchlist.execute(testTVSeriesDetail),
      ).thenAnswer((_) async => Right("Added to Watchlist"));
      bloc.emit(TVSeriesDetailLoadedState(isAddedToWatchlist: false));
      return bloc;
    },
    act:
        (bloc) => bloc.add(
          AddTVSeriesWatchlistEvent(tvSeriesDetail: testTVSeriesDetail),
        ),
    expect:
        () => [
          TVSeriesDetailLoadedState(
            isAddedToWatchlist: true,
            watchlistSuccessMessage: "Added to Watchlist",
          ),
        ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTVSeriesDetail));
    },
  );

  blocTest<TvSeriesDetailBloc, TVSeriesDetailState>(
    "should emit TVSeriesDetailLoadedState when data is removed from wishlist",
    build: () {
      when(
        mockRemoveWatchlist.execute(testTVSeriesDetail),
      ).thenAnswer((_) async => Right("Removed from Watchlist"));
      bloc.emit(TVSeriesDetailLoadedState(isAddedToWatchlist: true));
      return bloc;
    },
    act:
        (bloc) => bloc.add(
          RemoveTVSeriesWatchlistEvent(tvSeriesDetail: testTVSeriesDetail),
        ),
    expect:
        () => [
          TVSeriesDetailLoadedState(
            isAddedToWatchlist: false,
            watchlistSuccessMessage: "Removed from Watchlist",
          ),
        ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTVSeriesDetail));
    },
  );
}
