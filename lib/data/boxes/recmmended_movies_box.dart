import 'package:film_ku/data/model/movie_model.dart';
import 'package:film_ku/data/register_adapter.dart';
import 'package:hive/hive.dart';

class RecommendedMoviesBox {
  static final RecommendedMoviesBox _singleton = RecommendedMoviesBox._internal();

  factory RecommendedMoviesBox() {
    return _singleton;
  }

  RecommendedMoviesBox._internal();

  Box<MovieModel> getRecommendedMoviesBox() {
    return Hive.box<MovieModel>(boxNameRecommendedMovies);
  }

  /// save Movies
  void saveRecommendedMovies(List<MovieModel> recommendList) async {
    Map<int, MovieModel> movieMap = {
      for(var recommendMovie in recommendList) recommendMovie.id ?? 0: recommendMovie
    };

    await getRecommendedMoviesBox().putAll(movieMap);
  }

  /// retrieve Movies
  List<MovieModel> getAllRecommendedMovies() {
    return getRecommendedMoviesBox().values.toList();
  }
}