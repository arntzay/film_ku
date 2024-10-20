import 'package:film_ku/data/model/movie_model.dart';
import 'package:film_ku/data/register_adapter.dart';
import 'package:hive/hive.dart';

class BannerBox {
  static final BannerBox _singleton = BannerBox._internal();

  factory BannerBox() {
    return _singleton;
  }

  BannerBox._internal();

  Box<MovieModel> getBannerBox() {
    return Hive.box<MovieModel>(boxNameBanner);
  }

  /// save movies
  void saveMovies(List<MovieModel> bannerList) async {
    Map<int, MovieModel> bannerMap = {
      for (var movieModel in bannerList) movieModel.id ?? 0 : movieModel
    };

    await getBannerBox().putAll(bannerMap);
  }

  /// retrieve movies
  List<MovieModel> getAllBannerMovies() {
    return getBannerBox().values.toList();
  }
}
