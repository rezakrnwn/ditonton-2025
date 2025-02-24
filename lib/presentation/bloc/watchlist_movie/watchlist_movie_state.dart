part of 'watchlist_movie_bloc.dart';

@immutable
abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieInitial extends WatchlistMovieState {}

class WatchlistMovieLoadedState extends WatchlistMovieState {
  final List<Movie> watchlist;

  WatchlistMovieLoadedState({required this.watchlist});

  @override
  List<Object> get props => [watchlist];
}

class LoadWatchlistMovieFailureState extends WatchlistMovieState {
  final String message;

  LoadWatchlistMovieFailureState({
    this.message = "",
  });
}
