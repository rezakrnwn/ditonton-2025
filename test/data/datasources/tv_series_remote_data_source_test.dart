import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';
  late MockIOClient mockHttpClient;
  late TVSeriesRemoteDataSource tvSeriesRemoteDataSource;

  setUp(() {
    mockHttpClient = MockIOClient();
    tvSeriesRemoteDataSource = TVSeriesRemoteDataSourceImpl(mockHttpClient);
  });

  group('get Now Playing TV Series', () {
    final tvSeriesModelListMatcher = TVSeriesResponse.fromJson(
            jsonDecode(readJson('dummy_data/tv_series_now_playing.json')))
        .results;
    test('should return TV Series Model List when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer(
        (_) async => http.Response(
            readJson('dummy_data/tv_series_now_playing.json'), 200),
      );
      // act
      final result = await tvSeriesRemoteDataSource.getNowPlaying();
      // assert
      expect(result, equals(tvSeriesModelListMatcher));
    });

    test('should throw ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer(
        (_) async => http.Response('not found', 404),
      );
      // act
      final call = tvSeriesRemoteDataSource.getNowPlaying();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search TV Series', () {
    final searchResult = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_search_the_simpsons.json')))
        .results;
    final query = 'The Simpsons';

    test('should return list of tv series when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_search_the_simpsons.json'), 200));
      // act
      final result = await tvSeriesRemoteDataSource.search(query);
      // assert
      expect(result, searchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = tvSeriesRemoteDataSource.search(query);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
