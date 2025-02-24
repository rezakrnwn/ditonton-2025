import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetail extends Equatable {
  final String? backdropPath;
  final List<Genre>? genres;
  final int id;
  final String? name;
  final String? originalName;
  final String? originalLanguage;
  final List<String>? originCountry;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? firstAirDate;
  final double? voteAverage;
  final int? voteCount;

  TVSeriesDetail({
    this.name,
    this.backdropPath,
    this.genres,
    required this.id,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.firstAirDate,
    this.voteAverage,
    this.voteCount,
    this.originalLanguage,
    this.originCountry,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
        originalLanguage,
        originCountry,
      ];
}
