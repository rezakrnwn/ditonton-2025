import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'home_tv_series_event.dart';

part 'home_tv_series_state.dart';

class HomeTVSeriesBloc extends Bloc<HomeTVSeriesEvent, HomeTVSeriesState> {
  final GetNowPlayingTVSeries _getNowPlayingTVSeries;
  final GetPopularTVSeries _getPopularTVSeries;
  final GetTopRatedTVSeries _getTopRatedTVSeries;

  HomeTVSeriesBloc({
    required GetNowPlayingTVSeries getNowPlayingTVSeries,
    required GetPopularTVSeries getPopularTVSeries,
    required GetTopRatedTVSeries getTopRatedTVSeries,
  })  : _getNowPlayingTVSeries = getNowPlayingTVSeries,
        _getPopularTVSeries = getPopularTVSeries,
        _getTopRatedTVSeries = getTopRatedTVSeries,
        super(HomeTVSeriesInitial()) {
    on<LoadHomeTVSeriesEvent>(_loadHome);
  }

  void _loadHome(
    LoadHomeTVSeriesEvent event,
    Emitter<HomeTVSeriesState> emit,
  ) async {
    emit(
      HomeTVSeriesLoadedState(
        nowPlayingLoading: true,
        popularLoading: true,
        topRatedLoading: true,
      ),
    );

    await Future.wait([
      _getNowPlayingTVSeries.execute().then((e) {
        if (state is HomeTVSeriesLoadedState) {
          final currentState = state as HomeTVSeriesLoadedState;
          emit(
            currentState.copyWith(
              nowPlayingLoading: false,
              nowPlayingTvSeries: e.toOption().toNullable(),
              nowPlayingErrorMessage: e.fold((l) => l.message, (_) => null),
            ),
          );
        }
      }),
      _getPopularTVSeries.execute().then((e) {
        if (state is HomeTVSeriesLoadedState) {
          final currentState = state as HomeTVSeriesLoadedState;
          emit(
            currentState.copyWith(
              popularLoading: false,
              popularTvSeries: e.toOption().toNullable(),
              popularErrorMessage: e.fold((l) => l.message, (_) => null),
            ),
          );
        }
      }),
      _getTopRatedTVSeries.execute().then((e) {
        if (state is HomeTVSeriesLoadedState) {
          final currentState = state as HomeTVSeriesLoadedState;
          emit(
            currentState.copyWith(
              topRatedLoading: false,
              topRatedTvSeries: e.toOption().toNullable(),
              topRatedErrorMessage: e.fold((l) => l.message, (_) => null),
            ),
          );
        }
      }),
    ]);
  }
}
