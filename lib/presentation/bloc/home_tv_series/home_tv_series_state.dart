part of 'home_tv_series_bloc.dart';

abstract class HomeTVSeriesState extends Equatable {
  const HomeTVSeriesState();

  @override
  List<Object?> get props => [];
}

class HomeTVSeriesInitial extends HomeTVSeriesState {}

class HomeTVSeriesLoadedState extends HomeTVSeriesState {
  final List<TVSeries> nowPlayingTvSeries;
  final List<TVSeries> popularTvSeries;
  final List<TVSeries> topRatedTvSeries;
  final bool nowPlayingLoading;
  final bool popularLoading;
  final bool topRatedLoading;
  final String? nowPlayingErrorMessage;
  final String? popularErrorMessage;
  final String? topRatedErrorMessage;

  const HomeTVSeriesLoadedState({
    this.nowPlayingTvSeries = const [],
    this.popularTvSeries = const [],
    this.topRatedTvSeries = const [],
    this.nowPlayingLoading = false,
    this.popularLoading = false,
    this.topRatedLoading = false,
    this.nowPlayingErrorMessage,
    this.popularErrorMessage,
    this.topRatedErrorMessage,
  });

  HomeTVSeriesLoadedState copyWith({
    List<TVSeries>? nowPlayingTvSeries,
    List<TVSeries>? popularTvSeries,
    List<TVSeries>? topRatedTvSeries,
    bool? nowPlayingLoading,
    bool? popularLoading,
    bool? topRatedLoading,
    String? nowPlayingErrorMessage,
    String? popularErrorMessage,
    String? topRatedErrorMessage,
  }) => HomeTVSeriesLoadedState(
    nowPlayingTvSeries: nowPlayingTvSeries ?? this.nowPlayingTvSeries,
    popularTvSeries: popularTvSeries ?? this.popularTvSeries,
    topRatedTvSeries: topRatedTvSeries ?? this.topRatedTvSeries,
    nowPlayingLoading: nowPlayingLoading ?? this.nowPlayingLoading,
    popularLoading: popularLoading ?? this.popularLoading,
    topRatedLoading: topRatedLoading ?? this.topRatedLoading,
    nowPlayingErrorMessage: nowPlayingErrorMessage ?? this.nowPlayingErrorMessage,
    popularErrorMessage: popularErrorMessage ?? this.popularErrorMessage,
    topRatedErrorMessage: topRatedErrorMessage ?? this.topRatedErrorMessage,
  );

  @override
  List<Object?> get props => [
    nowPlayingTvSeries,
    popularTvSeries,
    topRatedTvSeries,
    nowPlayingLoading,
    popularLoading,
    topRatedLoading,
  ];
}

class LoadHomeTVSeriesFailureState extends HomeTVSeriesState {
  final String message;

  LoadHomeTVSeriesFailureState({
    this.message = "",
  });
}
