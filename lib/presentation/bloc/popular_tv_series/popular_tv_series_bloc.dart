import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_series_event.dart';

part 'popular_tv_series_state.dart';

class PopularTVSeriesBloc
    extends Bloc<PopularTVSeriesEvent, PopularTVSeriesState> {
  final GetPopularTVSeries _getPopularTVSeries;

  PopularTVSeriesBloc({required GetPopularTVSeries getPopularTVSeries})
    : _getPopularTVSeries = getPopularTVSeries,
      super(PopularTVSeriesInitial()) {
    on<LoadPopularTVSeriesEvent>(_onLoadPopularTvSeries);
  }

  void _onLoadPopularTvSeries(
    LoadPopularTVSeriesEvent event,
    Emitter<PopularTVSeriesState> emit,
  ) async {
    emit(PopularTVSeriesInitial());
    final result = await _getPopularTVSeries.execute();
    result.fold(
      (failure) =>
          emit(LoadPopularTVSeriesFailureState(message: failure.message)),
      (data) {
        emit(PopularTVSeriesLoadedState(
          tvSeries: data,
        ));
      },
    );
  }
}
