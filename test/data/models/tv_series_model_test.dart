import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tvSeriesModel = TVSeriesModel(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 5.0,
    posterPath: 'posterPath',
    voteAverage: 2.0,
    voteCount: 4,
  );

  final tvSeries = TVSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 5.0,
    posterPath: 'posterPath',
    voteAverage: 2.0,
    voteCount: 4,
  );

  final tvSeriesMap = {
    'backdrop_path': 'backdropPath',
    'first_air_date': 'firstAirDate',
    'genre_ids': [1],
    'id': 1,
    'name': 'name',
    'origin_country': ['originCountry'],
    'original_language': 'originalLanguage',
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 5.0,
    'poster_path': 'posterPath',
    'vote_average': 2.0,
    'vote_count': 4,
  };

  test('should be a subclass of TV Series entity', () async {
    final result = tvSeriesModel.toEntity();
    expect(result, tvSeries);
  });

  test('should return a JSON map containing proper data', () {
    final result = tvSeriesModel.toJson();

    expect(result, tvSeriesMap);
  });

  test('should create a valid model from JSON', () {
    final result = TVSeriesModel.fromJson(tvSeriesMap);
    expect(result, tvSeriesModel);
  });

  test('should support value equality', () {
    final other = TVSeriesModel.fromJson(tvSeriesMap);
    expect(tvSeriesModel, equals(other));
  });

  test('should return correct props', () {
    expect(tvSeriesModel.props, [
      'backdropPath',
      [1],
      1,
      'originalName',
      'overview',
      5.0,
      'posterPath',
      'firstAirDate',
      'name',
      2.0,
      4,
      'originalLanguage',
      ['originCountry'],
    ]);
  });
}
