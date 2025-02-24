import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/home_movie/home_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_movie_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomeMoviePage({super.key, required this.scaffoldKey});

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  late final HomeMovieBloc homeMovieBloc;

  @override
  void initState() {
    super.initState();
    homeMovieBloc = locator();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeMovieBloc..add(LoadHomeMovieEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ditonton - Movies'),
          leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.dehaze),
            onPressed: () {
              widget.scaffoldKey.currentState?.openDrawer();
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchMoviePage.ROUTE_NAME);
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Now Playing', style: kHeading6),
                BlocBuilder<HomeMovieBloc, HomeMovieState>(
                  builder: (context, state) {
                    if (state is HomeMovieInitial || (state is HomeMovieLoadedState && state.nowPlayingLoading)) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is HomeMovieLoadedState && !state.nowPlayingLoading && (state.nowPlayingErrorMessage?.isEmpty ?? true)) {
                      return MovieList(state.nowPlayingMovies);
                    } else {
                      final errorMessage = () {
                        if (state is HomeMovieLoadedState && (state.nowPlayingErrorMessage?.isNotEmpty ?? false)) {
                          return state.nowPlayingErrorMessage ?? '';
                        }

                        return 'Load data failed';
                      }();
                      return Text(errorMessage);
                    } 
                  },
                ),
                _buildSubHeading(
                  title: 'Popular',
                  onTap:
                      () => Navigator.pushNamed(
                        context,
                        PopularMoviesPage.ROUTE_NAME,
                      ),
                ),
                BlocBuilder<HomeMovieBloc, HomeMovieState>(
                  builder: (context, state) {
                     if (state is HomeMovieInitial || (state is HomeMovieLoadedState && state.popularLoading)) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is HomeMovieLoadedState && !state.popularLoading && (state.popularErrorMessage?.isEmpty ?? true)) {
                      return MovieList(state.popularMovies);
                    } else {
                      final errorMessage = () {
                        if (state is HomeMovieLoadedState && (state.popularErrorMessage?.isNotEmpty ?? false)) {
                          return state.popularErrorMessage ?? '';
                        }

                        return 'Load data failed';
                      }();
                      return Text(errorMessage);
                    }
                  },
                ),
                _buildSubHeading(
                  title: 'Top Rated',
                  onTap:
                      () => Navigator.pushNamed(
                        context,
                        TopRatedMoviesPage.ROUTE_NAME,
                      ),
                ),
                BlocBuilder<HomeMovieBloc, HomeMovieState>(
                  builder: (context, state) {
                     if (state is HomeMovieInitial || (state is HomeMovieLoadedState && state.topRatedLoading)) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is HomeMovieLoadedState && !state.topRatedLoading && (state.topRatedErrorMessage?.isEmpty ?? true)) {
                      return MovieList(state.topRatedMovies);
                    } else {
                      final errorMessage = () {
                        if (state is HomeMovieLoadedState && (state.topRatedErrorMessage?.isNotEmpty ?? false)) {
                          return state.topRatedErrorMessage ?? '';
                        }

                        return 'Load data failed';
                      }();
                      return Text(errorMessage);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder:
                      (context, url) =>
                          Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
