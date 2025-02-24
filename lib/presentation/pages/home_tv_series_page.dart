import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/home_tv_series/home_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvSeriesPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomeTvSeriesPage({super.key, required this.scaffoldKey});

  @override
  State<HomeTvSeriesPage> createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  late final HomeTVSeriesBloc homeTVSeriesBloc;

  @override
  void initState() {
    homeTVSeriesBloc = locator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeTVSeriesBloc..add(LoadHomeTVSeriesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ditonton -  Tv Series'),
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
                Navigator.pushNamed(context, SearchTvSeriesPage.ROUTE_NAME);
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
                BlocBuilder<HomeTVSeriesBloc, HomeTVSeriesState>(
                  builder: (context, state) {
                    if (state is HomeTVSeriesInitial ||
                        (state is HomeTVSeriesLoadedState &&
                            state.nowPlayingLoading)) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is HomeTVSeriesLoadedState &&
                        !state.nowPlayingLoading &&
                        (state.nowPlayingErrorMessage?.isEmpty ?? true)) {
                      return TvSeriesList(state.nowPlayingTvSeries);
                    } else {
                      final errorMessage = () {
                        if (state is HomeTVSeriesLoadedState &&
                            (state.nowPlayingErrorMessage?.isNotEmpty ??
                                false)) {
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
                        PopularTvSeriesPage.ROUTE_NAME,
                      ),
                ),
                BlocBuilder<HomeTVSeriesBloc, HomeTVSeriesState>(
                  builder: (context, state) {
                    if (state is HomeTVSeriesInitial ||
                        (state is HomeTVSeriesLoadedState &&
                            state.popularLoading)) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is HomeTVSeriesLoadedState &&
                        !state.popularLoading &&
                        (state.popularErrorMessage?.isEmpty ?? true)) {
                      return TvSeriesList(state.popularTvSeries);
                    } else {
                      final errorMessage = () {
                        if (state is HomeTVSeriesLoadedState &&
                            (state.popularErrorMessage?.isNotEmpty ?? false)) {
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
                        TopRatedTvSeriesPage.ROUTE_NAME,
                      ),
                ),
                BlocBuilder<HomeTVSeriesBloc, HomeTVSeriesState>(
                  builder: (context, state) {
                    if (state is HomeTVSeriesInitial ||
                        (state is HomeTVSeriesLoadedState &&
                            state.topRatedLoading)) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is HomeTVSeriesLoadedState &&
                        !state.topRatedLoading &&
                        (state.topRatedErrorMessage?.isEmpty ?? true)) {
                      return TvSeriesList(state.topRatedTvSeries);
                    } else {
                      final errorMessage = () {
                        if (state is HomeTVSeriesLoadedState &&
                            (state.topRatedErrorMessage?.isNotEmpty ?? false)) {
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

class TvSeriesList extends StatelessWidget {
  final List<TVSeries> tvSeries;

  TvSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final data = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: data.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${data.posterPath}',
                  placeholder:
                      (context, url) =>
                          Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
