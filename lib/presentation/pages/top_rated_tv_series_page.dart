import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  const TopRatedTvSeriesPage({super.key});

  @override
  State<TopRatedTvSeriesPage> createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  late final TopRatedTVSeriesBloc topRatedTVSeriesBloc;

  @override
  void initState() {
    topRatedTVSeriesBloc = locator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => topRatedTVSeriesBloc..add(LoadTopRatedTVSeriesEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text('Top Rated Tv Series')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
            builder: (context, state) {
              if (state is TopRatedTVSeriesInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TopRatedTVSeriesLoadedState) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = state.tvSeries[index];
                    return TVSeriesCard(tv);
                  },
                  itemCount: state.tvSeries.length,
                );
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text(
                    state is LoadTopRatedTVSeriesFailureState
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
