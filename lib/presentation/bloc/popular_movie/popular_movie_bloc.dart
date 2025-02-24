import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _getPopularMovies;
  PopularMovieBloc({required GetPopularMovies getPopularMovies})
    : _getPopularMovies = getPopularMovies,
      super(PopularMovieInitial()) {
    on<LoadPopularMovieEvent>(_onLoadPopularMovie);
  }

  void _onLoadPopularMovie(
    LoadPopularMovieEvent event,
    Emitter<PopularMovieState> emit,
  ) async {
    emit(PopularMovieInitial());
    final result = await _getPopularMovies.execute();
    result.fold(
      (failure) => emit(LoadPopularMovieFailureState(message: failure.message)),
      (data) {
        emit(PopularMovieLoadedState(
          movies: data,
        ));
      },
    );
  }
}
