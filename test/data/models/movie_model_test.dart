import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieMap = {
    "adult": false,
    "backdrop_path": "backdropPath",
    "genre_ids": [1, 2, 3],
    "id": 1,
    "original_title": "originalTitle",
    "overview": "overview",
    "popularity": 1.0,
    "poster_path": "posterPath",
    "release_date": "releaseDate",
    "title": "title",
    "video": false,
    "vote_average": 1.0,
    "vote_count": 1,
  };

  test('should be a subclass of Movie entity', () async {
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });

  test('should return a valid model from JSON', () {
    final result = MovieModel.fromJson(tMovieMap);
    expect(result, equals(tMovieModel));
  });

  test('should return a JSON map containing proper data', () {
    final result = tMovieModel.toJson();
    expect(result, equals(tMovieMap));
  });

  test('should support value equality', () {
    final other = MovieModel.fromJson(tMovieMap);
    expect(tMovieModel, equals(other));
  });

  test('should return correct props', () {
    expect(tMovieModel.props, [
      false,
      'backdropPath',
      [1, 2, 3],
      1,
      'originalTitle',
      'overview',
      1,
      'posterPath',
      'releaseDate',
      'title',
      false,
      1,
      1,
    ]);
  });
}
