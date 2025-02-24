import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  const WatchlistTvSeriesPage({super.key});

  @override
  State<WatchlistTvSeriesPage> createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage> {
  late final WatchlistTVSeriesBloc watchlistTVSeriesBloc;

  @override
  void initState() {
    watchlistTVSeriesBloc = locator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => watchlistTVSeriesBloc..add(LoadWatchlistTVSeriesEvent()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
            builder: (context, state) {
              if (state is WatchlistTVSeriesInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is WatchlistTVSeriesLoadedState) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = state.watchlist[index];
                    return TVSeriesCard(
                      tv,
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          TvSeriesDetailPage.ROUTE_NAME,
                          arguments: tv.id,
                        ).then(
                          (_) =>
                              watchlistTVSeriesBloc
                                ..add(LoadWatchlistTVSeriesEvent()),
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
                    state is LoadWatchlistTVSeriesFailureState
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
