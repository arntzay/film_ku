import 'package:dartz/dartz.dart';
import 'package:film_ku/data/api/custom_failure.dart';
import 'package:film_ku/data/model/genre_model.dart';
import 'package:film_ku/data/model/movie_model.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieModel>>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<GenreModel>> getGenreList();
  Future<List<MovieModel>> getMoviesByGenre(int genreId);
  Future<MovieModel> getMovieDetail(int movieId);
}