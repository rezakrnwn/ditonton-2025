import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  const PopularTvSeriesPage({super.key});

  @override
  State<PopularTvSeriesPage> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  late final PopularTVSeriesBloc popularTVSeriesBloc;

  @override
  void initState() {
    popularTVSeriesBloc = locator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => popularTVSeriesBloc..add(LoadPopularTVSeriesEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text('Popular Tv Series')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularTVSeriesBloc, PopularTVSeriesState>(
            builder: (context, state) {
              if (state is PopularTVSeriesInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is PopularTVSeriesLoadedState) {
                return ListView.builder(
                  itemCount: state.tvSeries.length,
                  itemBuilder: (context, index) {
                    final tv = state.tvSeries[index];
                    return TVSeriesCard(tv);
                  },
                );
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text(
                    state is LoadPopularTVSeriesFailureState
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
