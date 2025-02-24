import 'package:equatable/equatable.dart';

class TVSeries extends Equatable {
  final String? backdropPath;
  final List<int>? genreIds;
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

  TVSeries({
    this.name,
    this.backdropPath,
    this.genreIds,
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

  TVSeries.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  })  : backdropPath = '',
        genreIds = [],
        originalName = '',
        originalLanguage = '',
        firstAirDate = '',
        originCountry = [],
        popularity = 0,
        voteAverage = 0,
        voteCount = 0;

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
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
