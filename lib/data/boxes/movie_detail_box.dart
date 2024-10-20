import 'package:film_ku/data/model/movie_model.dart';
import 'package:film_ku/data/register_adapter.dart';
import 'package:hive/hive.dart';

class MovieDetailBox {
  static final MovieDetailBox _singleton = MovieDetailBox._internal();

  factory MovieDetailBox() {
    return _singleton;
  }

  MovieDetailBox._internal();

  Box<MovieModel> getMovieDetailBox() {
    return Hive.box<MovieModel>(boxNameMovieDetail);
  }

  void saveSingleMovie(MovieModel? movieModel) async {
    if(movieModel != null) {
      await getMovieDetailBox().put(movieModel.id ?? 0, movieModel);
    }
  }

  MovieModel? getMovieById(int movieId) {
    return getMovieDetailBox().get(movieId);
  }
}