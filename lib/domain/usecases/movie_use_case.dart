import 'package:dartz/dartz.dart';
import 'package:film_ku/data/api/custom_failure.dart';
import 'package:film_ku/data/model/genre_model.dart';
import 'package:film_ku/data/model/movie_model.dart';
import 'package:film_ku/data/repositories/movie_repository_impl.dart';
import 'package:film_ku/domain/repositories/movie_repository.dart';

class MovieUseCase {
  static final MovieUseCase _singleton = MovieUseCase._internal();

  factory MovieUseCase() {
    return _singleton;
  }

  MovieUseCase._internal();

  /// Repositories
  MovieRepository movieRepository = MovieRepositoryImpl();

  Future<Either<Failure, List<MovieModel>>> getNowPlayingMovies() {
    return movieRepository.getNowPlayingMovies();
  }

  Future<List<MovieModel>> getPopularMovies() {
    return movieRepository.getPopularMovies();
  }

  Future<List<GenreModel>> getGenreList() {
    return movieRepository.getGenreList();
  }

  Future<List<MovieModel>> getMoviesByGenre(int genreId) {
    return movieRepository.getMoviesByGenre(genreId);
  }

  Future<MovieModel> getMovieDetail(int movieId) {
    return movieRepository.getMovieDetail(movieId);
  }
}