import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  late final PopularMovieBloc popularMovieBloc;

  @override
  void initState() {
    super.initState();
    popularMovieBloc = locator();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => popularMovieBloc..add(LoadPopularMovieEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text('Popular Movies')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
            builder: (context, state) {
              if (state is PopularMovieInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is PopularMovieLoadedState) {
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
                    state is LoadPopularMovieFailureState
                        ? state.message
                        : 'Load data failed',
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
