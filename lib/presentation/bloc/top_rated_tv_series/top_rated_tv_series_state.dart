part of 'top_rated_tv_series_bloc.dart';

abstract class TopRatedTVSeriesState extends Equatable {
  const TopRatedTVSeriesState();

  @override
  List<Object?> get props => [];
}

class TopRatedTVSeriesInitial extends TopRatedTVSeriesState {}

class TopRatedTVSeriesLoadedState extends TopRatedTVSeriesState {
  final List<TVSeries> tvSeries;

  TopRatedTVSeriesLoadedState({required this.tvSeries});

  @override
  List<Object?> get props => [tvSeries];
}

class LoadTopRatedTVSeriesFailureState extends TopRatedTVSeriesState {
  final String message;

  LoadTopRatedTVSeriesFailureState({
    this.message = "",
  });

  @override
  List<Object?> get props => [message];
}
