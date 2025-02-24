import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const ROUTE_NAME = '/about';
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AboutPage(
    this.scaffoldKey,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ditonton - About"),
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: kPrussianBlue,
              child: Center(
                child: Image.asset(
                  'assets/circle-g.png',
                  width: 128,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32.0),
              color: kMikadoYellow,
              child: Text(
                'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.',
                style: TextStyle(color: Colors.black87, fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
