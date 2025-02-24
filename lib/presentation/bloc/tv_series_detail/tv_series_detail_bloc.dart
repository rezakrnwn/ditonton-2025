import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';

part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TVSeriesDetailEvent, TVSeriesDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVSeriesDetail _getTVSeriesDetail;
  final GetTVSeriesRecommendations _getTVSeriesRecommendations;
  final GetWatchListStatusTVSeries _getWatchListStatusTVSeries;
  final SaveWatchlistTVSeries _saveWatchlistTVSeries;
  final RemoveWatchlistTVSeries _removeWatchlistTVSeries;

  TvSeriesDetailBloc({
    required GetTVSeriesDetail getTVSeriesDetail,
    required GetTVSeriesRecommendations getTVSeriesRecommendations,
    required GetWatchListStatusTVSeries getWatchListStatusTVSeries,
    required SaveWatchlistTVSeries saveWatchlistTVSeries,
    required RemoveWatchlistTVSeries removeWatchlistTVSeries,
  }) : _getTVSeriesDetail = getTVSeriesDetail,
       _getTVSeriesRecommendations = getTVSeriesRecommendations,
       _getWatchListStatusTVSeries = getWatchListStatusTVSeries,
       _saveWatchlistTVSeries = saveWatchlistTVSeries,
       _removeWatchlistTVSeries = removeWatchlistTVSeries,
       super(TVSeriesDetailInitial()) {
    on<LoadTVSeriesDetailEvent>(_loadDetail);
    on<AddTVSeriesWatchlistEvent>(_addWatchlist);
    on<RemoveTVSeriesWatchlistEvent>(_removeFromWatchlist);
  }

  void _loadDetail(
    LoadTVSeriesDetailEvent event,
    Emitter<TVSeriesDetailState> emit,
  ) async {
    await Future.wait([
      _getTVSeriesDetail.execute(event.id).then((result) {
        if (state is TVSeriesDetailLoadedState) {
          final currentState = state as TVSeriesDetailLoadedState;
          final tvSeriesDetail = result.toOption().toNullable();
          result.fold(
            (l) => emit(LoadTVSeriesDetailFailureState(message: l.message)),
            (r) => emit(
              currentState.copyWith(
                tvSeriesDetail: tvSeriesDetail,
                genres: _toGenresString(tvSeriesDetail?.genres ?? []),
              ),
            ),
          );
        } else {
          result.fold(
            (l) => emit(LoadTVSeriesDetailFailureState(message: l.message)),
            (r) => emit(
              TVSeriesDetailLoadedState(
                tvSeriesDetail: result.toOption().toNullable(),
              ),
            ),
          );
        }
      }),
      _getWatchListStatusTVSeries.execute(event.id).then((result) {
        if (state is TVSeriesDetailLoadedState) {
          final currentState = state as TVSeriesDetailLoadedState;
          emit(currentState.copyWith(isAddedToWatchlist: result));
        } else if (state is! LoadTVSeriesDetailFailureState) {
          emit(TVSeriesDetailLoadedState(isAddedToWatchlist: result));
        }
      }),
      _getTVSeriesRecommendations.execute(event.id).then((result) {
        if (state is TVSeriesDetailLoadedState) {
          final currentState = state as TVSeriesDetailLoadedState;
          emit(
            currentState.copyWith(
              tvSeriesRecommendations: result.toOption().toNullable(),
              tvSeriesRecommendationsErrorMessage: result.fold(
                (l) => l.message,
                (_) => null,
              ),
            ),
          );
        } else if (state is! LoadTVSeriesDetailFailureState) {
          emit(
            TVSeriesDetailLoadedState(
              tvSeriesRecommendations: result.toOption().toNullable() ?? [],
              tvSeriesRecommendationsErrorMessage: result.fold(
                (l) => l.message,
                (_) => null,
              ),
            ),
          );
        }
      }),
    ]);
  }

  void _addWatchlist(
    AddTVSeriesWatchlistEvent event,
    Emitter<TVSeriesDetailState> emit,
  ) async {
    final result = await _saveWatchlistTVSeries.execute(event.tvSeriesDetail);

    await result.fold(
      (failure) async {
        if (state is TVSeriesDetailLoadedState) {
          final currentState = state as TVSeriesDetailLoadedState;
          emit(currentState.copyWith(watchlistErrorMessage: failure.message));
        }
      },
      (successMessage) async {
        if (state is TVSeriesDetailLoadedState) {
          final currentState = state as TVSeriesDetailLoadedState;
          emit(
            currentState.copyWith(
              isAddedToWatchlist: true,
              watchlistSuccessMessage: successMessage,
            ),
          );
        }
      },
    );
  }

  void _removeFromWatchlist(
    RemoveTVSeriesWatchlistEvent event,
    Emitter<TVSeriesDetailState> emit,
  ) async {
    final result = await _removeWatchlistTVSeries.execute(event.tvSeriesDetail);

    await result.fold(
      (failure) async {
        if (state is TVSeriesDetailLoadedState) {
          final currentState = state as TVSeriesDetailLoadedState;
          emit(currentState.copyWith(watchlistErrorMessage: failure.message));
        }
      },
      (successMessage) async {
        if (state is TVSeriesDetailLoadedState) {
          final currentState = state as TVSeriesDetailLoadedState;
          emit(
            currentState.copyWith(
              isAddedToWatchlist: false,
              watchlistSuccessMessage: successMessage,
            ),
          );
        }
      },
    );
  }

  String _toGenresString(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
