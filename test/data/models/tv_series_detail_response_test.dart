import 'package:ditonton/data/models/tv_series_detail_response.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesDetailResponse = TVSeriesDetailResponse(
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    voteAverage: 1.0,
    voteCount: 1,
    popularity: 1.0,
    firstAirDate: 'firstAirDate',
    genres: [],
    originCountry: [],
    originalLanguage: 'id',
    backdropPath: 'backdropPath',
  );

  final tTvSeriesDetail = TVSeriesDetail(
    backdropPath: 'backdropPath',
    id: 1,
    originalName: 'originalName',
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    voteAverage: 1.0,
    voteCount: 1,
    popularity: 1.0,
    firstAirDate: 'firstAirDate',
    genres: [],
    originCountry: [],
    originalLanguage: 'id',
  );

  final tvSeriesDetailMap = {
    'backdrop_path': 'backdropPath',
    'episode_run_time': null,
    'first_air_date': 'firstAirDate',
    'genres': [],
    'homepage': null,
    'id': 1,
    'in_production': null,
    'languages': null,
    'last_air_date': null,
    'name': 'name',
    'next_episode_to_air': null,
    'number_of_episodes': null,
    'number_of_seasons': null,
    'origin_country': [],
    'original_language': 'id',
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 1.0,
    'poster_path': 'posterPath',
    'status': null,
    'tagline': null,
    'type': null,
    'vote_average': 1.0,
    'vote_count': 1,
  };

  test('should be a subclass of TV Series Detail entity', () {
    final entity = tTvSeriesDetailResponse.toEntity();
    expect(entity, tTvSeriesDetail);
  });

  test('should return a JSON map containing proper data', () {
    final result = tTvSeriesDetailResponse.toJson();
    expect(result, tvSeriesDetailMap);
  });

  test('should create a valid model from JSON', () {
    final result = TVSeriesDetailResponse.fromJson(tvSeriesDetailMap);
    expect(result, tTvSeriesDetailResponse);
  });

  test('should return correct props', () {
    expect(tTvSeriesDetailResponse.props, [
      1,
      'name',
      'originalName',
      'backdropPath',
      [],
      [],
      'firstAirDate',
      'id',
      'originalName',
      1.0,
      'overview',
      'posterPath',
      1.0,
      1,
    ]);
  });
}
