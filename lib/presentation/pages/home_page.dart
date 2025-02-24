import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_tv_series_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () => onDrawerTap(0),
            ),
            ListTile(
              leading: Icon(Icons.tv_outlined),
              title: Text('TV Series'),
              onTap: () => onDrawerTap(1),
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () => onDrawerTap(2),
            ),
            ListTile(
              onTap: () => onDrawerTap(3),
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          HomeMoviePage(
            scaffoldKey: scaffoldKey,
          ),
          HomeTvSeriesPage(
            scaffoldKey: scaffoldKey,
          ),
          WatchlistPage(scaffoldKey),
          AboutPage(
            scaffoldKey,
          ),
        ],
      ),
    );
  }

  void onDrawerTap(int page) {
    pageController.jumpToPage(page);
    Navigator.pop(context);
  }
}
