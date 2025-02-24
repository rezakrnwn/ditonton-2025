import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_series_detail_response.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:http/io_client.dart';

abstract class TVSeriesRemoteDataSource {
  Future<List<TVSeriesModel>> getNowPlaying();

  Future<List<TVSeriesModel>> getPopular();

  Future<List<TVSeriesModel>> getTopRated();

  Future<List<TVSeriesModel>> getRecommendations(int id);

  Future<List<TVSeriesModel>> search(String query);

  Future<TVSeriesDetailResponse> getDetail(int id);
}

class TVSeriesRemoteDataSourceImpl implements TVSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final IOClient _client;

  TVSeriesRemoteDataSourceImpl(
    this._client,
  );

  @override
  Future<List<TVSeriesModel>> getNowPlaying() async {
    final response =
        await _client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getPopular() async {
    final response =
        await _client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == HttpStatus.ok) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getTopRated() async {
    final response =
        await _client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == HttpStatus.ok) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> search(String query) async {
    final response = await _client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == HttpStatus.ok) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getRecommendations(int id) async {
    final response = await _client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == HttpStatus.ok) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVSeriesDetailResponse> getDetail(int id) async {
    final response = await _client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == HttpStatus.ok) {
      return TVSeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
