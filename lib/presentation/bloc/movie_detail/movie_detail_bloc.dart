import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieDetailBloc({
    required GetMovieDetail getMovieDetail,
    required GetMovieRecommendations getMovieRecommendations,
    required GetWatchListStatus getWatchListStatus,
    required SaveWatchlist saveWatchlist,
    required RemoveWatchlist removeWatchlist,
  }) : _getMovieDetail = getMovieDetail,
       _getMovieRecommendations = getMovieRecommendations,
       _getWatchListStatus = getWatchListStatus,
       _saveWatchlist = saveWatchlist,
       _removeWatchlist = removeWatchlist,
       super(MovieDetailInitial()) {
    on<LoadMovieDetailEvent>(_loadDetail);
    on<AddMovieWatchlistEvent>(_addWatchlist);
    on<RemoveMovieWatchlistEvent>(_removeFromWatchlist);
  }

  void _loadDetail(
    LoadMovieDetailEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    await Future.wait([
      _getMovieDetail.execute(event.id).then((result) {
        if (state is MovieDetailLoadedState) {
          final currentState = state as MovieDetailLoadedState;
          final movieDetail = result.toOption().toNullable();

          result.fold(
            (l) => emit(LoadMovieDetailFailureState(message: l.message)),
            (r) => emit(
              currentState.copyWith(
                movieDetail: movieDetail,
                genres: _toGenresString(movieDetail?.genres ?? []),
                duration: _formatDuration(movieDetail?.runtime ?? 0),
              ),
            ),
          );
        } else {
          result.fold(
            (l) => emit(LoadMovieDetailFailureState(message: l.message)),
            (r) => emit(
              MovieDetailLoadedState(
                movieDetail: result.toOption().toNullable(),
              ),
            ),
          );
        }
      }),
      _getWatchListStatus.execute(event.id).then((result) {
        if (state is MovieDetailLoadedState) {
          final currentState = state as MovieDetailLoadedState;
          emit(currentState.copyWith(isAddedToWatchlist: result));
        } else  if (state is! LoadMovieDetailFailureState) {
          emit(MovieDetailLoadedState(isAddedToWatchlist: result));
        }
      }),
      _getMovieRecommendations.execute(event.id).then((result) {
        if (state is MovieDetailLoadedState) {
          final currentState = state as MovieDetailLoadedState;
          emit(
            currentState.copyWith(
              movieRecommendations: result.toOption().toNullable(),
              movieRecommendationsErrorMessage: result.fold(
                (l) => l.message,
                (_) => null,
              ),
            ),
          );
        } else if (state is! LoadMovieDetailFailureState) {
          emit(
            MovieDetailLoadedState(
              movieRecommendations: result.toOption().toNullable() ?? [],
              movieRecommendationsErrorMessage: result.fold(
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
    AddMovieWatchlistEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await _saveWatchlist.execute(event.movie);

    await result.fold(
      (failure) async {
        if (state is MovieDetailLoadedState) {
          final currentState = state as MovieDetailLoadedState;
          emit(currentState.copyWith(watchlistErrorMessage: failure.message));
        }
      },
      (successMessage) async {
        if (state is MovieDetailLoadedState) {
          final currentState = state as MovieDetailLoadedState;
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
    RemoveMovieWatchlistEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await _removeWatchlist.execute(event.movie);

    await result.fold(
      (failure) async {
        if (state is MovieDetailLoadedState) {
          final currentState = state as MovieDetailLoadedState;
          emit(currentState.copyWith(watchlistErrorMessage: failure.message));
          emit(currentState.copyWith(watchlistErrorMessage: ''));
        }
      },
      (successMessage) async {
        if (state is MovieDetailLoadedState) {
          final currentState = state as MovieDetailLoadedState;
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

  String _formatDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
