import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  late final TopRatedMovieBloc topRatedMovieBloc;

  @override
  void initState() {
    topRatedMovieBloc = locator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => topRatedMovieBloc..add(LoadTopRatedMovieEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text('Top Rated Movies')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
            builder: (context, state) {
              if (state is TopRatedMovieInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TopRatedMovieLoadedState) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.movies.length,
                );
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text(
                    state is LoadTopRatedMovieFailureState
                        ? state.message
                        : "Load data failed",
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
