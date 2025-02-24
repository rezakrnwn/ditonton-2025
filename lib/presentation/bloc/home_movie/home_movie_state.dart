part of 'home_movie_bloc.dart';

abstract class HomeMovieState extends Equatable {
  const HomeMovieState();

  @override
  List<Object?> get props => [];
}

class HomeMovieInitial extends HomeMovieState {}

class HomeMovieLoadedState extends HomeMovieState {
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final bool nowPlayingLoading;
  final bool popularLoading;
  final bool topRatedLoading;
  final String? nowPlayingErrorMessage;
  final String? popularErrorMessage;
  final String? topRatedErrorMessage;

  const HomeMovieLoadedState({
    this.nowPlayingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.nowPlayingLoading = false,
    this.popularLoading = false,
    this.topRatedLoading = false,
    this.nowPlayingErrorMessage,
    this.popularErrorMessage,
    this.topRatedErrorMessage,
  });

  HomeMovieLoadedState copyWith({
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    bool? nowPlayingLoading,
    bool? popularLoading,
    bool? topRatedLoading,
    String? nowPlayingErrorMessage,
    String? popularErrorMessage,
    String? topRatedErrorMessage,
  }) => HomeMovieLoadedState(
    nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
    popularMovies: popularMovies ?? this.popularMovies,
    topRatedMovies: topRatedMovies ?? this.topRatedMovies,
    nowPlayingLoading: nowPlayingLoading ?? this.nowPlayingLoading,
    popularLoading: popularLoading ?? this.popularLoading,
    topRatedLoading: topRatedLoading ?? this.topRatedLoading,
    nowPlayingErrorMessage: nowPlayingErrorMessage ?? this.nowPlayingErrorMessage,
    popularErrorMessage: popularErrorMessage ?? this.popularErrorMessage,
    topRatedErrorMessage: topRatedErrorMessage ?? this.topRatedErrorMessage,
  );

  @override
  List<Object?> get props => [
    nowPlayingMovies,
    popularMovies,
    topRatedMovies,
    nowPlayingLoading,
    popularLoading,
    topRatedLoading,
  ];
}
