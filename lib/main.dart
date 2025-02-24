import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/home_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/search_movie_page.dart';
import 'package:ditonton/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        colorScheme: kColorScheme,
        primaryColor: kRichBlack,
        scaffoldBackgroundColor: kRichBlack,
        textTheme: kTextTheme,
        drawerTheme: kDrawerTheme,
      ),
      home: HomePage(),
      navigatorObservers: [routeObserver],
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case PopularMoviesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
          case PopularTvSeriesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
          case TopRatedMoviesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
          case TopRatedTvSeriesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
          case MovieDetailPage.ROUTE_NAME:
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => MovieDetailPage(id: id),
              settings: settings,
            );
          case TvSeriesDetailPage.ROUTE_NAME:
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => TvSeriesDetailPage(id: id),
              settings: settings,
            );
          case SearchMoviePage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => SearchMoviePage());
          case SearchTvSeriesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => SearchTvSeriesPage());
          case WatchlistMoviesPage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
          default:
            return MaterialPageRoute(
              builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
