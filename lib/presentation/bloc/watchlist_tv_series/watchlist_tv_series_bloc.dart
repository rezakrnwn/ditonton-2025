import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'watchlist_tv_series_event.dart';

part 'watchlist_tv_series_state.dart';

class WatchlistTVSeriesBloc
    extends Bloc<WatchlistTVSeriesEvent, WatchlistTVSeriesState> {
  final GetWatchlistTVSeries _getWatchlistTVSeries;

  WatchlistTVSeriesBloc({required GetWatchlistTVSeries getWatchlistTVSeries})
    : _getWatchlistTVSeries = getWatchlistTVSeries,
      super(WatchlistTVSeriesInitial()) {
    on<LoadWatchlistTVSeriesEvent>(_onLoadWatchlistTVSeries);
  }

  void _onLoadWatchlistTVSeries(
    LoadWatchlistTVSeriesEvent event,
    Emitter<WatchlistTVSeriesState> emit,
  ) async {
    emit(WatchlistTVSeriesInitial());
    final result = await _getWatchlistTVSeries.execute();
    result.fold(
      (failure) =>
          emit(LoadWatchlistTVSeriesFailureState(message: failure.message)),
      (data) {
        emit(WatchlistTVSeriesLoadedState(watchlist: data));
      },
    );
  }
}
