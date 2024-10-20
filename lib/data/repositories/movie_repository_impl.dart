import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:film_ku/data/api/api.dart';
import 'package:film_ku/data/api/custom_failure.dart';
import 'package:film_ku/data/api/error_handle.dart';
import 'package:film_ku/data/api/http_config.dart';
import 'package:film_ku/data/model/genre_model.dart';
import 'package:film_ku/data/model/movie_model.dart';
import 'package:film_ku/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  static final MovieRepositoryImpl _singleton = MovieRepositoryImpl._internal();

  factory MovieRepositoryImpl() {
    return _singleton;
  }

  MovieRepositoryImpl._internal();

  @override
  Future<Either<Failure, List<MovieModel>>> getNowPlayingMovies() async {
    var queryParam = {
      "api_key": HttpConfig.apiKey,
      "language": HttpConfig.language,
      "page": 1,
    };

    try {
      final response = await Api().dioInstance.get(
        HttpConfig.getNowPlayingMovies,
        queryParameters: queryParam,
      );

      print("Data Type a is ======> ${response.data.runtimeType}");

      List<MovieModel> movieList = (response.data["results"] as List)
          .map((movieJson) => MovieModel.fromJson(movieJson))
          .toList();

      return Right(movieList);
    } on DioException catch(error) {
      if(ErrorHandle.isConnectionError(error)) {
        return Left(ConnectionFailure());
      } else {
        return Left(ServerFailure(error: error.toString()));
      }
    } catch(error) {
      return Left(ServerFailure(error: error.toString()));
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    Map<String, dynamic> queryParam = {
      "api_key": HttpConfig.apiKey,
      "language": HttpConfig.language,
      "page": 1,
    };

    final response = await Api().dioInstance.get(
          HttpConfig.getPopularMovies,
          queryParameters: queryParam,
        );

    List<MovieModel> movieList = (response.data["results"] as List)
        .map((movieJson) => MovieModel.fromJson(movieJson))
        .toList();

    return movieList;
  }

  @override
  Future<List<GenreModel>> getGenreList() async {
    final queryParam = {
      "api_key": HttpConfig.apiKey,
    };

    final response = await Api()
        .dioInstance
        .get(HttpConfig.getGenres, queryParameters: queryParam);

    List<GenreModel> genreList = (response.data["genres"] as List)
        .map((genreJson) => GenreModel.fromJson(genreJson))
        .toList();

    return genreList;
  }

  @override
  Future<List<MovieModel>> getMoviesByGenre(int genreId) async {
    final queryParam = {
      "with_genres": genreId,
      "api_key": HttpConfig.apiKey,
    };

    final response = await Api()
        .dioInstance
        .get(HttpConfig.getMoviesByGenre, queryParameters: queryParam);

    List<MovieModel> movieList =
        (response.data["results"] as List).map((movieJson) {
      return MovieModel.fromJson(movieJson);
    }).toList();

    return movieList;
  }

  @override
  Future<MovieModel> getMovieDetail(int movieId) async {
    final queryParam = {
      "api_key": HttpConfig.apiKey,
      "language": HttpConfig.language,
    };

    final response = await Api().dioInstance.get(
          "${HttpConfig.getMovieDetail}/$movieId",
          queryParameters: queryParam,
        );

    return MovieModel.fromJson(response.data);
  }
}

/// Map<String, dynamic>

/// API ခေါ်ရင် အသုံးများတဲ့ Method 4 မျိုး
/// GET
/// POST
/// PUT
/// DELETE
