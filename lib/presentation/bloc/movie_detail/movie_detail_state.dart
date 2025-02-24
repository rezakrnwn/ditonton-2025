part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailLoadedState extends MovieDetailState {
  final MovieDetail? movieDetail;
  final List<Movie>? movieRecommendations;
  final bool isAddedToWatchlist;
  final String? genres;
  final String? duration;
  final String? watchlistSuccessMessage;
  final String? watchlistErrorMessage;
  final String? movieRecommendationsErrorMessage;

  MovieDetailLoadedState({
    this.movieDetail,
    this.movieRecommendations = const [],
    this.isAddedToWatchlist = false,
    this.genres,
    this.duration,
    this.watchlistSuccessMessage,
    this.watchlistErrorMessage,
    this.movieRecommendationsErrorMessage,
  });

  MovieDetailLoadedState copyWith({
    MovieDetail? movieDetail,
    List<Movie>? movieRecommendations,
    bool? isAddedToWatchlist,
    String? genres,
    String? duration,
    String? watchlistSuccessMessage,
    String? watchlistErrorMessage,
    String? movieRecommendationsErrorMessage,
  }) => MovieDetailLoadedState(
    movieDetail: movieDetail ?? this.movieDetail,
    movieRecommendations: movieRecommendations ?? this.movieRecommendations,
    duration: duration ?? this.duration,
    genres: genres ?? this.genres,
    isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    watchlistSuccessMessage:
        watchlistSuccessMessage ?? this.watchlistSuccessMessage,
    watchlistErrorMessage: watchlistErrorMessage ?? this.watchlistErrorMessage,
    movieRecommendationsErrorMessage:
        movieRecommendationsErrorMessage ??
        this.movieRecommendationsErrorMessage,
  );

  @override
  List<Object?> get props => [
    movieDetail,
    movieRecommendations,
    isAddedToWatchlist,
    genres,
    duration,
    watchlistSuccessMessage,
    watchlistErrorMessage,
    movieRecommendationsErrorMessage,
  ];
}

class LoadMovieDetailFailureState extends MovieDetailState {
  final String message;

  LoadMovieDetailFailureState({this.message = ""});
}
