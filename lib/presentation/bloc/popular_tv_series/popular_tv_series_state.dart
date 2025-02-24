part of 'popular_tv_series_bloc.dart';

abstract class PopularTVSeriesState extends Equatable {
  const PopularTVSeriesState();

  @override
  List<Object> get props => [];
}

class PopularTVSeriesInitial extends PopularTVSeriesState {}

class PopularTVSeriesLoadedState extends PopularTVSeriesState {
  final List<TVSeries> tvSeries;

  PopularTVSeriesLoadedState({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}

class LoadPopularTVSeriesFailureState extends PopularTVSeriesState {
  final String message;

  LoadPopularTVSeriesFailureState({
    this.message = "",
  });

  @override
  List<Object> get props => [message];
}
