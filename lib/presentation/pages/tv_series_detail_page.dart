import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv-series';
  final int id;

  const TvSeriesDetailPage({super.key, required this.id});

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  late final TvSeriesDetailBloc tvSeriesDetailBloc;

  @override
  void initState() {
    tvSeriesDetailBloc = locator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              tvSeriesDetailBloc..add(LoadTVSeriesDetailEvent(id: widget.id)),
      child: BlocListener<TvSeriesDetailBloc, TVSeriesDetailState>(
        listener: (context, state) {
          if (state is TVSeriesDetailLoadedState) {
            if (state.watchlistSuccessMessage?.isNotEmpty ?? false) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.watchlistSuccessMessage ?? '')),
              );
            } else if (state.watchlistErrorMessage?.isNotEmpty ?? false) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.watchlistErrorMessage ?? ''),
                  );
                },
              );
            }
          }
        },
        child: Scaffold(
          body: BlocBuilder<TvSeriesDetailBloc, TVSeriesDetailState>(
            builder: (context, state) {
              if (state is TVSeriesDetailInitial ||
                  (state is TVSeriesDetailLoadedState &&
                      state.tvSeriesDetail == null)) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TVSeriesDetailLoadedState &&
                  state.tvSeriesDetail != null) {
                return SafeArea(
                  child: DetailContent(
                    state.tvSeriesDetail!,
                    state.isAddedToWatchlist,
                  ),
                );
              } else {
                final errorMessage = () {
                  if (state is LoadTVSeriesDetailFailureState) {
                    return state.message;
                  }

                  return 'Load data failed';
                }();
                return Text(errorMessage);
              }
            },
          ),
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TVSeriesDetail tvSeriesDetail;
  final bool isAddedWatchlist;

  DetailContent(
    this.tvSeriesDetail,
    this.isAddedWatchlist,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tvSeriesDetailBloc = BlocProvider.of<TvSeriesDetailBloc>(context);
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
          width: screenWidth,
          placeholder:
              (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tvSeriesDetail.name ?? '', style: kHeading5),
                            FilledButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  tvSeriesDetailBloc.add(AddTVSeriesWatchlistEvent(tvSeriesDetail: tvSeriesDetail));
                                } else {
                                  tvSeriesDetailBloc.add(RemoveTVSeriesWatchlistEvent(tvSeriesDetail: tvSeriesDetail));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(_showGenres(tvSeriesDetail.genres ?? [])),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: (tvSeriesDetail.voteAverage ?? 0) / 2,
                                  itemCount: 5,
                                  itemBuilder:
                                      (context, index) => Icon(
                                        Icons.star,
                                        color: kMikadoYellow,
                                      ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeriesDetail.voteAverage}'),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text('Overview', style: kHeading6),
                            Text(tvSeriesDetail.overview ?? ''),
                            SizedBox(height: 16),
                            Text('Recommendations', style: kHeading6),
                            BlocBuilder<TvSeriesDetailBloc, TVSeriesDetailState>(
                              builder: (context, state) {
                               if (state is TVSeriesDetailInitial ||
                                    (state is TVSeriesDetailLoadedState &&
                                        state.tvSeriesRecommendations == null)) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TVSeriesDetailLoadedState &&
                                    (state
                                            .tvSeriesRecommendationsErrorMessage
                                            ?.isNotEmpty ??
                                        false)) {
                                  return Text(state.tvSeriesRecommendationsErrorMessage ?? '');
                                } else if (state is TVSeriesDetailLoadedState &&
                                    state.tvSeriesRecommendations != null) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvSeries = state.tvSeriesRecommendations![index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvSeriesDetailPage.ROUTE_NAME,
                                                arguments: tvSeries.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                                                placeholder:
                                                    (context, url) => Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.tvSeriesRecommendations?.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
