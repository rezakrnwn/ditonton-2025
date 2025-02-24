import 'package:ditonton/common/constants.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/search-movie';

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  late final SearchMovieBloc searchMovieBloc;

  @override
  void initState() {
    searchMovieBloc = locator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchMovieBloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Search Movie')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onSubmitted: (query) {
                  searchMovieBloc.add(LoadSearchResultMovieEvent(keyword: query));
                },
                decoration: InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              SizedBox(height: 16),
              Text('Search Result', style: kHeading6),
              BlocBuilder<SearchMovieBloc, SearchMovieState>(
                builder: (context, state) {
                  if (state is SearchMovieLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SearchResultMovieLoadedState) {
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final movie = state.movies[index];
                          return MovieCard(movie);
                        },
                        itemCount: state.movies.length,
                      ),
                    );
                  } else {
                    return SizedBox.expand();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
