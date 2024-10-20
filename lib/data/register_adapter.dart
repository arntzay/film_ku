import 'package:film_ku/data/model/genre_model.dart';
import 'package:film_ku/data/model/movie_model.dart';
import 'package:hive/hive.dart';

Future<void> registerAdapters() async {
  Hive.registerAdapter(MovieModelAdapter());
  Hive.registerAdapter(GenreModelAdapter());

  await Hive.openBox<MovieModel>(boxNameBanner);
  await Hive.openBox<MovieModel>(boxNameRecommendedMovies);
  await Hive.openBox<MovieModel>(boxNameMovieDetail);
}

const int movieModelTypeId = 1;
const int genreModelTypeId = 2;

const String boxNameBanner = "boxNameBanner";
const String boxNameRecommendedMovies = "boxNameRecommendedMovies";
const String boxNameMovieDetail = "boxNameMovieDetail";