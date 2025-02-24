part of 'search_tv_series_bloc.dart';

abstract class SearchTVSeriesState extends Equatable {
  const SearchTVSeriesState();

  @override
  List<Object> get props => [];
}

class SearchTVSeriesInitial extends SearchTVSeriesState {}

class SearchTVSeriesLoadingState extends SearchTVSeriesState {}

class SearchResultTVSeriesLoadedState extends SearchTVSeriesState {
  final List<TVSeries> tvSeries;

  SearchResultTVSeriesLoadedState({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}

class LoadSearchTVSeriesFailureState extends SearchTVSeriesState {
  final String message;

  LoadSearchTVSeriesFailureState({this.message = ""});

  @override
  List<Object> get props => [message];
}
