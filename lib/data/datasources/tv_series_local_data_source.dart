import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_series_table.dart';

abstract class TVSeriesLocalDataSource {
  Future<String> insertWatchlist(TVSeriesTable tvSeries);
  Future<String> removeWatchlist(TVSeriesTable tvSeries);
  Future<TVSeriesTable?> getById(int id);
  Future<List<TVSeriesTable>> getWatchlist();
}

class TVSeriesLocalDataSourceImpl implements TVSeriesLocalDataSource {
  final DatabaseHelper _databaseHelper;

  TVSeriesLocalDataSourceImpl(
    this._databaseHelper,
  );

  @override
  Future<TVSeriesTable?> getById(int id) async {
    final result = await _databaseHelper.getTVSeriesById(id);
    if (result != null) {
      return TVSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TVSeriesTable>> getWatchlist() async {
    final result = await _databaseHelper.getTVSeriesWatchlist();
    return result.map((data) => TVSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(TVSeriesTable tvSeries) async {
    try {
      await _databaseHelper.insertTVSeriesWatchlist(tvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TVSeriesTable tvSeries) async {
    try {
      await _databaseHelper.removeTVSeriesWatchlist(tvSeries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
