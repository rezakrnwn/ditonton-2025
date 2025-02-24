import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'watchlist_movie_event.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  
  WatchlistMovieBloc({
    required GetWatchlistMovies getWatchlistMovies,
  })  : _getWatchlistMovies = getWatchlistMovies,
        super(WatchlistMovieInitial()) {
    on<LoadWatchlistMovieEvent>(_onLoadWatchlistMovie);
  }

  void _onLoadWatchlistMovie(LoadWatchlistMovieEvent event, Emitter<WatchlistMovieState> emit) async {
    emit(WatchlistMovieInitial());
      final result = await _getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(LoadWatchlistMovieFailureState()),
        (data) {
          emit(WatchlistMovieLoadedState(
            watchlist: data,
          ));
        },
      );
  }
}
