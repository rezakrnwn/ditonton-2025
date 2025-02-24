part of 'tv_series_detail_bloc.dart';

abstract class TVSeriesDetailState extends Equatable {
  const TVSeriesDetailState();

  @override
  List<Object?> get props => [];
}

class TVSeriesDetailInitial extends TVSeriesDetailState {}

class TVSeriesDetailLoadingState extends TVSeriesDetailState {}

class TVSeriesDetailLoadedState extends TVSeriesDetailState {
  final TVSeriesDetail? tvSeriesDetail;
  final List<TVSeries>? tvSeriesRecommendations;
  final bool isAddedToWatchlist;
  final String? genres;
  final String? watchlistSuccessMessage;
  final String? watchlistErrorMessage;
  final String? tvSeriesRecommendationsErrorMessage;

  TVSeriesDetailLoadedState({
    this.tvSeriesDetail,
    this.tvSeriesRecommendations = const [],
    this.isAddedToWatchlist = false,
    this.genres,
    this.watchlistSuccessMessage,
    this.watchlistErrorMessage,
    this.tvSeriesRecommendationsErrorMessage,
  });

  TVSeriesDetailLoadedState copyWith({
    TVSeriesDetail? tvSeriesDetail,
    List<TVSeries>? tvSeriesRecommendations,
    bool? isAddedToWatchlist,
    String? genres,
    String? duration,
    String? watchlistSuccessMessage,
    String? watchlistErrorMessage,
    String? tvSeriesRecommendationsErrorMessage,
  }) => TVSeriesDetailLoadedState(
    tvSeriesDetail: tvSeriesDetail ?? this.tvSeriesDetail,
    tvSeriesRecommendations:
        tvSeriesRecommendations ?? this.tvSeriesRecommendations,
    genres: genres ?? this.genres,
    isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    watchlistSuccessMessage:
        watchlistSuccessMessage ?? this.watchlistSuccessMessage,
    watchlistErrorMessage: watchlistErrorMessage ?? this.watchlistErrorMessage,
    tvSeriesRecommendationsErrorMessage:
        tvSeriesRecommendationsErrorMessage ??
        this.tvSeriesRecommendationsErrorMessage,
  );

  @override
  List<Object?> get props => [
    tvSeriesDetail,
    tvSeriesRecommendations,
    isAddedToWatchlist,
    genres,
    watchlistSuccessMessage,
    watchlistErrorMessage,
    tvSeriesRecommendationsErrorMessage,
  ];
}

class LoadTVSeriesDetailFailureState extends TVSeriesDetailState {
  final String message;

  LoadTVSeriesDetailFailureState({this.message = ""});
}
