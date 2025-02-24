part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieInitial extends SearchMovieState {}

class SearchMovieLoadingState extends SearchMovieState {}

class SearchResultMovieLoadedState extends SearchMovieState {
  final List<Movie> movies;

  SearchResultMovieLoadedState({required this.movies});

  @override
  List<Object> get props => [movies];
}

class LoadSearchMovieFailureState extends SearchMovieState {
  final String message;

  LoadSearchMovieFailureState({
    this.message = "",
  });

  @override
  List<Object> get props => [message];
}
