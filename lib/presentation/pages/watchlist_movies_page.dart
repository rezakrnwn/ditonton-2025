import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> {
  late final WatchlistMovieBloc watchlistMovieBloc;
  @override
  void initState() {
    super.initState();
    watchlistMovieBloc = locator();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => watchlistMovieBloc..add(LoadWatchlistMovieEvent()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
            builder: (context, state) {
              if (state is WatchlistMovieInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is WatchlistMovieLoadedState) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.watchlist[index];
                    return MovieCard(
                      movie,
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          MovieDetailPage.ROUTE_NAME,
                          arguments: movie.id,
                        ).then(
                          (_) =>
                              watchlistMovieBloc.add(LoadWatchlistMovieEvent()),
                        );
                      },
                    );
                  },
                  itemCount: state.watchlist.length,
                );
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text(
                    state is LoadWatchlistMovieFailureState
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

  @override
  void dispose() {
    super.dispose();
  }
}
