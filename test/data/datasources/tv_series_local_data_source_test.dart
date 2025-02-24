import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSeriesLocalDataSource tvSeriesLocalDataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    tvSeriesLocalDataSource = TVSeriesLocalDataSourceImpl(mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTVSeriesWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await tvSeriesLocalDataSource.insertWatchlist(testTVSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTVSeriesWatchlist(testTVSeriesTable))
          .thenThrow(Exception());
      // act
      final call = tvSeriesLocalDataSource.insertWatchlist(testTVSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTVSeriesWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await tvSeriesLocalDataSource.removeWatchlist(testTVSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTVSeriesWatchlist(testTVSeriesTable))
          .thenThrow(Exception());
      // act
      final call = tvSeriesLocalDataSource.removeWatchlist(testTVSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TV Series Detail By Id', () {
    final id = 1;

    test('should return TV Series Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTVSeriesById(id))
          .thenAnswer((_) async => testTVSeriesMap);
      // act
      final result = await tvSeriesLocalDataSource.getById(id);
      // assert
      expect(result, testTVSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTVSeriesById(id)).thenAnswer((_) async => null);
      // act
      final result = await tvSeriesLocalDataSource.getById(id);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TVSeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getTVSeriesWatchlist())
          .thenAnswer((_) async => [testTVSeriesMap]);
      // act
      final result = await tvSeriesLocalDataSource.getWatchlist();
      // assert
      expect(result, [testTVSeriesTable]);
    });
  });
}