// Mocks generated by Mockito 5.4.4 from annotations
// in ditonton/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:convert' as _i26;
import 'dart:typed_data' as _i27;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/failure.dart' as _i9;
import 'package:ditonton/data/datasources/db/database_helper.dart' as _i24;
import 'package:ditonton/data/datasources/movie_local_data_source.dart' as _i14;
import 'package:ditonton/data/datasources/movie_remote_data_source.dart'
    as _i12;
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart'
    as _i22;
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart'
    as _i20;
import 'package:ditonton/data/models/movie_detail_model.dart' as _i3;
import 'package:ditonton/data/models/movie_model.dart' as _i13;
import 'package:ditonton/data/models/movie_table.dart' as _i15;
import 'package:ditonton/data/models/tv_series_detail_response.dart' as _i4;
import 'package:ditonton/data/models/tv_series_model.dart' as _i21;
import 'package:ditonton/data/models/tv_series_table.dart' as _i23;
import 'package:ditonton/domain/entities/movie.dart' as _i10;
import 'package:ditonton/domain/entities/movie_detail.dart' as _i11;
import 'package:ditonton/domain/entities/tv_series.dart' as _i18;
import 'package:ditonton/domain/entities/tv_series_detail.dart' as _i19;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i7;
import 'package:ditonton/domain/repositories/tv_series_repository.dart' as _i17;
import 'package:http/http.dart' as _i5;
import 'package:http/io_client.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i16;
import 'package:sqflite/sqflite.dart' as _i25;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieDetailResponse_1 extends _i1.SmartFake
    implements _i3.MovieDetailResponse {
  _FakeMovieDetailResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTVSeriesDetailResponse_2 extends _i1.SmartFake
    implements _i4.TVSeriesDetailResponse {
  _FakeTVSeriesDetailResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_3 extends _i1.SmartFake implements _i5.Response {
  _FakeResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_4 extends _i1.SmartFake
    implements _i5.StreamedResponse {
  _FakeStreamedResponse_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIOStreamedResponse_5 extends _i1.SmartFake
    implements _i6.IOStreamedResponse {
  _FakeIOStreamedResponse_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i7.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
                _FakeEither_0<_i9.Failure, List<_i10.Movie>>(
          this,
          Invocation.method(
            #getNowPlayingMovies,
            [],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
                _FakeEither_0<_i9.Failure, List<_i10.Movie>>(
          this,
          Invocation.method(
            #getPopularMovies,
            [],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
                _FakeEither_0<_i9.Failure, List<_i10.Movie>>(
          this,
          Invocation.method(
            #getTopRatedMovies,
            [],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, _i11.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, _i11.MovieDetail>>.value(
                _FakeEither_0<_i9.Failure, _i11.MovieDetail>(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, _i11.MovieDetail>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieRecommendations,
          [id],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
                _FakeEither_0<_i9.Failure, List<_i10.Movie>>(
          this,
          Invocation.method(
            #getMovieRecommendations,
            [id],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
                _FakeEither_0<_i9.Failure, List<_i10.Movie>>(
          this,
          Invocation.method(
            #searchMovies,
            [query],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> saveWatchlist(
          _i11.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [movie],
        ),
        returnValue: _i8.Future<_i2.Either<_i9.Failure, String>>.value(
            _FakeEither_0<_i9.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [movie],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, String>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> removeWatchlist(
          _i11.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [movie],
        ),
        returnValue: _i8.Future<_i2.Either<_i9.Failure, String>>.value(
            _FakeEither_0<_i9.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [movie],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, String>>);

  @override
  _i8.Future<bool> isAddedToWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlist,
          [id],
        ),
        returnValue: _i8.Future<bool>.value(false),
      ) as _i8.Future<bool>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
                _FakeEither_0<_i9.Failure, List<_i10.Movie>>(
          this,
          Invocation.method(
            #getWatchlistMovies,
            [],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i12.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<List<_i13.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
        ),
        returnValue:
            _i8.Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]),
      ) as _i8.Future<List<_i13.MovieModel>>);

  @override
  _i8.Future<List<_i13.MovieModel>> getPopularMovies() => (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue:
            _i8.Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]),
      ) as _i8.Future<List<_i13.MovieModel>>);

  @override
  _i8.Future<List<_i13.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue:
            _i8.Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]),
      ) as _i8.Future<List<_i13.MovieModel>>);

  @override
  _i8.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue: _i8.Future<_i3.MovieDetailResponse>.value(
            _FakeMovieDetailResponse_1(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i8.Future<_i3.MovieDetailResponse>);

  @override
  _i8.Future<List<_i13.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieRecommendations,
          [id],
        ),
        returnValue:
            _i8.Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]),
      ) as _i8.Future<List<_i13.MovieModel>>);

  @override
  _i8.Future<List<_i13.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue:
            _i8.Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]),
      ) as _i8.Future<List<_i13.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i14.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<String> insertWatchlist(_i15.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [movie],
        ),
        returnValue: _i8.Future<String>.value(_i16.dummyValue<String>(
          this,
          Invocation.method(
            #insertWatchlist,
            [movie],
          ),
        )),
      ) as _i8.Future<String>);

  @override
  _i8.Future<String> removeWatchlist(_i15.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [movie],
        ),
        returnValue: _i8.Future<String>.value(_i16.dummyValue<String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [movie],
          ),
        )),
      ) as _i8.Future<String>);

  @override
  _i8.Future<_i15.MovieTable?> getMovieById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i8.Future<_i15.MovieTable?>.value(),
      ) as _i8.Future<_i15.MovieTable?>);

  @override
  _i8.Future<List<_i15.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue:
            _i8.Future<List<_i15.MovieTable>>.value(<_i15.MovieTable>[]),
      ) as _i8.Future<List<_i15.MovieTable>>);
}

/// A class which mocks [TVSeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVSeriesRepository extends _i1.Mock
    implements _i17.TVSeriesRepository {
  MockTVSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>> getNowPlaying() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlaying,
          [],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>>.value(
                _FakeEither_0<_i9.Failure, List<_i18.TVSeries>>(
          this,
          Invocation.method(
            #getNowPlaying,
            [],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>> getPopular() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopular,
          [],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>>.value(
                _FakeEither_0<_i9.Failure, List<_i18.TVSeries>>(
          this,
          Invocation.method(
            #getPopular,
            [],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>> getTopRated() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRated,
          [],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>>.value(
                _FakeEither_0<_i9.Failure, List<_i18.TVSeries>>(
          this,
          Invocation.method(
            #getTopRated,
            [],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, _i19.TVSeriesDetail>> getDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDetail,
          [id],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, _i19.TVSeriesDetail>>.value(
                _FakeEither_0<_i9.Failure, _i19.TVSeriesDetail>(
          this,
          Invocation.method(
            #getDetail,
            [id],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, _i19.TVSeriesDetail>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>> getRecommendations(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRecommendations,
          [id],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>>.value(
                _FakeEither_0<_i9.Failure, List<_i18.TVSeries>>(
          this,
          Invocation.method(
            #getRecommendations,
            [id],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>> search(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #search,
          [query],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>>.value(
                _FakeEither_0<_i9.Failure, List<_i18.TVSeries>>(
          this,
          Invocation.method(
            #search,
            [query],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> saveWatchlist(
          _i19.TVSeriesDetail? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [tvSeries],
        ),
        returnValue: _i8.Future<_i2.Either<_i9.Failure, String>>.value(
            _FakeEither_0<_i9.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [tvSeries],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, String>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> removeWatchlist(
          _i19.TVSeriesDetail? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tvSeries],
        ),
        returnValue: _i8.Future<_i2.Either<_i9.Failure, String>>.value(
            _FakeEither_0<_i9.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [tvSeries],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, String>>);

  @override
  _i8.Future<bool> isAddedToWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlist,
          [id],
        ),
        returnValue: _i8.Future<bool>.value(false),
      ) as _i8.Future<bool>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>> getWatchlist() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>>.value(
                _FakeEither_0<_i9.Failure, List<_i18.TVSeries>>(
          this,
          Invocation.method(
            #getWatchlist,
            [],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i18.TVSeries>>>);
}

/// A class which mocks [TVSeriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVSeriesRemoteDataSource extends _i1.Mock
    implements _i20.TVSeriesRemoteDataSource {
  MockTVSeriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<List<_i21.TVSeriesModel>> getNowPlaying() => (super.noSuchMethod(
        Invocation.method(
          #getNowPlaying,
          [],
        ),
        returnValue:
            _i8.Future<List<_i21.TVSeriesModel>>.value(<_i21.TVSeriesModel>[]),
      ) as _i8.Future<List<_i21.TVSeriesModel>>);

  @override
  _i8.Future<List<_i21.TVSeriesModel>> getPopular() => (super.noSuchMethod(
        Invocation.method(
          #getPopular,
          [],
        ),
        returnValue:
            _i8.Future<List<_i21.TVSeriesModel>>.value(<_i21.TVSeriesModel>[]),
      ) as _i8.Future<List<_i21.TVSeriesModel>>);

  @override
  _i8.Future<List<_i21.TVSeriesModel>> getTopRated() => (super.noSuchMethod(
        Invocation.method(
          #getTopRated,
          [],
        ),
        returnValue:
            _i8.Future<List<_i21.TVSeriesModel>>.value(<_i21.TVSeriesModel>[]),
      ) as _i8.Future<List<_i21.TVSeriesModel>>);

  @override
  _i8.Future<List<_i21.TVSeriesModel>> getRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRecommendations,
          [id],
        ),
        returnValue:
            _i8.Future<List<_i21.TVSeriesModel>>.value(<_i21.TVSeriesModel>[]),
      ) as _i8.Future<List<_i21.TVSeriesModel>>);

  @override
  _i8.Future<List<_i21.TVSeriesModel>> search(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #search,
          [query],
        ),
        returnValue:
            _i8.Future<List<_i21.TVSeriesModel>>.value(<_i21.TVSeriesModel>[]),
      ) as _i8.Future<List<_i21.TVSeriesModel>>);

  @override
  _i8.Future<_i4.TVSeriesDetailResponse> getDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDetail,
          [id],
        ),
        returnValue: _i8.Future<_i4.TVSeriesDetailResponse>.value(
            _FakeTVSeriesDetailResponse_2(
          this,
          Invocation.method(
            #getDetail,
            [id],
          ),
        )),
      ) as _i8.Future<_i4.TVSeriesDetailResponse>);
}

/// A class which mocks [TVSeriesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVSeriesLocalDataSource extends _i1.Mock
    implements _i22.TVSeriesLocalDataSource {
  MockTVSeriesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<String> insertWatchlist(_i23.TVSeriesTable? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [tvSeries],
        ),
        returnValue: _i8.Future<String>.value(_i16.dummyValue<String>(
          this,
          Invocation.method(
            #insertWatchlist,
            [tvSeries],
          ),
        )),
      ) as _i8.Future<String>);

  @override
  _i8.Future<String> removeWatchlist(_i23.TVSeriesTable? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tvSeries],
        ),
        returnValue: _i8.Future<String>.value(_i16.dummyValue<String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [tvSeries],
          ),
        )),
      ) as _i8.Future<String>);

  @override
  _i8.Future<_i23.TVSeriesTable?> getById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getById,
          [id],
        ),
        returnValue: _i8.Future<_i23.TVSeriesTable?>.value(),
      ) as _i8.Future<_i23.TVSeriesTable?>);

  @override
  _i8.Future<List<_i23.TVSeriesTable>> getWatchlist() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue:
            _i8.Future<List<_i23.TVSeriesTable>>.value(<_i23.TVSeriesTable>[]),
      ) as _i8.Future<List<_i23.TVSeriesTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i24.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i25.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i8.Future<_i25.Database?>.value(),
      ) as _i8.Future<_i25.Database?>);

  @override
  _i8.Future<int> insertWatchlist(_i15.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [movie],
        ),
        returnValue: _i8.Future<int>.value(0),
      ) as _i8.Future<int>);

  @override
  _i8.Future<int> removeWatchlist(_i15.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [movie],
        ),
        returnValue: _i8.Future<int>.value(0),
      ) as _i8.Future<int>);

  @override
  _i8.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i8.Future<Map<String, dynamic>?>.value(),
      ) as _i8.Future<Map<String, dynamic>?>);

  @override
  _i8.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue: _i8.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i8.Future<List<Map<String, dynamic>>>);

  @override
  _i8.Future<int> insertTVSeriesWatchlist(_i23.TVSeriesTable? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertTVSeriesWatchlist,
          [tvSeries],
        ),
        returnValue: _i8.Future<int>.value(0),
      ) as _i8.Future<int>);

  @override
  _i8.Future<int> removeTVSeriesWatchlist(_i23.TVSeriesTable? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeTVSeriesWatchlist,
          [tvSeries],
        ),
        returnValue: _i8.Future<int>.value(0),
      ) as _i8.Future<int>);

  @override
  _i8.Future<Map<String, dynamic>?> getTVSeriesById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTVSeriesById,
          [id],
        ),
        returnValue: _i8.Future<Map<String, dynamic>?>.value(),
      ) as _i8.Future<Map<String, dynamic>?>);

  @override
  _i8.Future<List<Map<String, dynamic>>> getTVSeriesWatchlist() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTVSeriesWatchlist,
          [],
        ),
        returnValue: _i8.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i8.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i5.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i8.Future<_i5.Response>);

  @override
  _i8.Future<_i5.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i8.Future<_i5.Response>);

  @override
  _i8.Future<_i5.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i26.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i5.Response>);

  @override
  _i8.Future<_i5.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i26.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i5.Response>);

  @override
  _i8.Future<_i5.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i26.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i5.Response>);

  @override
  _i8.Future<_i5.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i26.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i5.Response>);

  @override
  _i8.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<String>.value(_i16.dummyValue<String>(
          this,
          Invocation.method(
            #read,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i8.Future<String>);

  @override
  _i8.Future<_i27.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i27.Uint8List>.value(_i27.Uint8List(0)),
      ) as _i8.Future<_i27.Uint8List>);

  @override
  _i8.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i8.Future<_i5.StreamedResponse>.value(_FakeStreamedResponse_4(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i8.Future<_i5.StreamedResponse>);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [IOClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockIOClient extends _i1.Mock implements _i6.IOClient {
  MockIOClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i6.IOStreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i8.Future<_i6.IOStreamedResponse>.value(_FakeIOStreamedResponse_5(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i8.Future<_i6.IOStreamedResponse>);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i8.Future<_i5.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i8.Future<_i5.Response>);

  @override
  _i8.Future<_i5.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i8.Future<_i5.Response>);

  @override
  _i8.Future<_i5.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i26.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i5.Response>);

  @override
  _i8.Future<_i5.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i26.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i5.Response>);

  @override
  _i8.Future<_i5.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i26.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i5.Response>);

  @override
  _i8.Future<_i5.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i26.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i5.Response>);

  @override
  _i8.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<String>.value(_i16.dummyValue<String>(
          this,
          Invocation.method(
            #read,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i8.Future<String>);

  @override
  _i8.Future<_i27.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i27.Uint8List>.value(_i27.Uint8List(0)),
      ) as _i8.Future<_i27.Uint8List>);
}
