import 'package:ditonton/common/ssl_helper.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/home_movie/home_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/home_tv_series/home_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';

final locator = GetIt.instance;

Future<void> init() async {
  IOClient ioClient = await SSLHelper.ioClient;

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTVSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVSeries(locator()));
  locator.registerLazySingleton(() => GetTVSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTVSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTVSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTVSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TVSeriesRepository>(
    () => TVSeriesRepositoryImpl(
      tvSeriesLocalDataSource: locator(),
      tvSeriesRemoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(databaseHelper: locator()),
  );
  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
    () => TVSeriesRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<TVSeriesLocalDataSource>(
    () => TVSeriesLocalDataSourceImpl(locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton<IOClient>(() => ioClient);

  // bloc
  locator.registerFactory(
    () => HomeMovieBloc(
      getNowPlayingMovies: locator(),
      getTopRatedMovies: locator(),
      getPopularMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => HomeTVSeriesBloc(
      getNowPlayingTVSeries: locator(),
      getTopRatedTVSeries: locator(),
      getPopularTVSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMovieBloc(getTopRatedMovies: locator()),
  );
  locator.registerFactory(
    () => TopRatedTVSeriesBloc(getTopRatedTVSeries: locator()),
  );
  locator.registerFactory(() => PopularMovieBloc(getPopularMovies: locator()));
  locator.registerFactory(
    () => PopularTVSeriesBloc(getPopularTVSeries: locator()),
  );
  locator.registerFactory(() => SearchTVSeriesBloc(searchTVSeries: locator()));
  locator.registerFactory(() => SearchMovieBloc(searchMovies: locator()));
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailBloc(
      getWatchListStatusTVSeries: locator(),
      getTVSeriesRecommendations: locator(),
      getTVSeriesDetail: locator(),
      removeWatchlistTVSeries: locator(),
      saveWatchlistTVSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(getWatchlistMovies: locator()),
  );
  locator.registerFactory(
    () => WatchlistTVSeriesBloc(getWatchlistTVSeries: locator()),
  );
}
