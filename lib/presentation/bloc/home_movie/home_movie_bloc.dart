import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'home_movie_event.dart';

part 'home_movie_state.dart';

class HomeMovieBloc extends Bloc<HomeMovieEvent, HomeMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;

  HomeMovieBloc({
    required GetNowPlayingMovies getNowPlayingMovies,
    required GetPopularMovies getPopularMovies,
    required GetTopRatedMovies getTopRatedMovies,
  }) : _getNowPlayingMovies = getNowPlayingMovies,
       _getPopularMovies = getPopularMovies,
       _getTopRatedMovies = getTopRatedMovies,
       super(HomeMovieInitial()) {
    on<LoadHomeMovieEvent>(_onLoadHome);
  }
  void _onLoadHome(LoadHomeMovieEvent event, Emitter<HomeMovieState> emit) async {
    emit(
      HomeMovieLoadedState(
        nowPlayingLoading: true,
        popularLoading: true,
        topRatedLoading: true,
      ),
    );

    await Future.wait([
      _getNowPlayingMovies.execute().then((e) {
        if (state is HomeMovieLoadedState) {
          final currentState = state as HomeMovieLoadedState;
          emit(
            currentState.copyWith(
              nowPlayingLoading: false,
              nowPlayingMovies: e.toOption().toNullable(),
              nowPlayingErrorMessage: e.fold((l) => l.message, (_) => null),
            ),
          );
        }
      }),
      _getPopularMovies.execute().then((e) {
        if (state is HomeMovieLoadedState) {
          final currentState = state as HomeMovieLoadedState;
          emit(
            currentState.copyWith(
              popularLoading: false,
              popularMovies: e.toOption().toNullable(),
              popularErrorMessage: e.fold((l) => l.message, (_) => null),
            ),
          );
        }
      }),
      _getTopRatedMovies.execute().then((e) {
        if (state is HomeMovieLoadedState) {
          final currentState = state as HomeMovieLoadedState;
          emit(
            currentState.copyWith(
              topRatedLoading: false,
              topRatedMovies: e.toOption().toNullable(),
              topRatedErrorMessage: e.fold((l) => l.message, (_) => null),
            ),
          );
        }
      }),
    ]);
  }
}
