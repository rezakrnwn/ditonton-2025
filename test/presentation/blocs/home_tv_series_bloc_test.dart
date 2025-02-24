import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/home_tv_series/home_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTVSeries, GetPopularTVSeries, GetTopRatedTVSeries])
void main() {
  late HomeTVSeriesBloc bloc;
  late MockGetNowPlayingTVSeries mockGetNowPlayingTVSeries;
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;

  setUp(() {
    mockGetNowPlayingTVSeries = MockGetNowPlayingTVSeries();
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    bloc = HomeTVSeriesBloc(
      getNowPlayingTVSeries: mockGetNowPlayingTVSeries,
      getPopularTVSeries: mockGetPopularTVSeries,
      getTopRatedTVSeries: mockGetTopRatedTVSeries,
    );
  });

  blocTest<HomeTVSeriesBloc, HomeTVSeriesState>(
    'should emits loading state then loaded state when fetching tv series succeeds',
    build: () {
      when(
        mockGetNowPlayingTVSeries.execute(),
      ).thenAnswer((_) async => Right([tvSeries]));
      when(
        mockGetPopularTVSeries.execute(),
      ).thenAnswer((_) async => Right([tvSeries]));
      when(
        mockGetTopRatedTVSeries.execute(),
      ).thenAnswer((_) async => Right([tvSeries]));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadHomeTVSeriesEvent()),
    expect:
        () => [
          HomeTVSeriesLoadedState(
            nowPlayingLoading: true,
            popularLoading: true,
            topRatedLoading: true,
          ),
          HomeTVSeriesLoadedState(
            nowPlayingLoading: false,
            popularLoading: true,
            topRatedLoading: true,
            nowPlayingTvSeries: [tvSeries],
          ),
          HomeTVSeriesLoadedState(
            nowPlayingLoading: false,
            popularLoading: false,
            topRatedLoading: true,
            nowPlayingTvSeries: [tvSeries],
            popularTvSeries: [tvSeries],
          ),
          HomeTVSeriesLoadedState(
            nowPlayingLoading: false,
            popularLoading: false,
            topRatedLoading: false,
            nowPlayingTvSeries: [tvSeries],
            popularTvSeries: [tvSeries],
            topRatedTvSeries: [tvSeries],
          ),
        ],
    verify: (bloc) {
      verify(mockGetNowPlayingTVSeries.execute());
      verify(mockGetPopularTVSeries.execute());
      verify(mockGetTopRatedTVSeries.execute());
    },
  );

  blocTest<HomeTVSeriesBloc, HomeTVSeriesState>(
    'should emits error state when fetching tv series fails',
    build: () {
      when(
        mockGetNowPlayingTVSeries.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Failed to load')));
      when(
        mockGetPopularTVSeries.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Failed to load')));
      when(
        mockGetTopRatedTVSeries.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Failed to load')));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadHomeTVSeriesEvent()),
    expect:
        () => [
          HomeTVSeriesLoadedState(
            nowPlayingLoading: true,
            popularLoading: true,
            topRatedLoading: true,
          ),
          HomeTVSeriesLoadedState(
            nowPlayingLoading: false,
            popularLoading: true,
            topRatedLoading: true,
            nowPlayingErrorMessage: 'Failed to load',
          ),
          HomeTVSeriesLoadedState(
            nowPlayingLoading: false,
            popularLoading: false,
            topRatedLoading: true,
            nowPlayingErrorMessage: 'Failed to load',
            popularErrorMessage: 'Failed to load',
          ),
          HomeTVSeriesLoadedState(
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
