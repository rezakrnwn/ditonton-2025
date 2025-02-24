import 'package:ditonton/common/constants.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/search-tv-series';

  @override
  State<SearchTvSeriesPage> createState() => _SearchTvSeriesPageState();
}

class _SearchTvSeriesPageState extends State<SearchTvSeriesPage> {
  late final SearchTVSeriesBloc searchTVSeriesBloc;

  @override
  void initState() {
    searchTVSeriesBloc = locator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchTVSeriesBloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Search Tv Series')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onSubmitted: (query) {
                  searchTVSeriesBloc.add(LoadSearchResultTVSeriesEvent(keyword: query));
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
              BlocBuilder<SearchTVSeriesBloc, SearchTVSeriesState>(
                builder: (context, state) {
                  if (state is SearchTVSeriesLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SearchResultTVSeriesLoadedState) {
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final tvSeries = state.tvSeries[index];
                          return TVSeriesCard(tvSeries);
                        },
                        itemCount: state.tvSeries.length,
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
