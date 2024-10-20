class HttpConfig {
  static String baseUrl = "https://api.themoviedb.org/3";
  static String imageBaseUrl = "http://image.tmdb.org/t/p/w400";

  static String apiKey = "19d6149f34738ec93c495cd0527246ae";
  static String language = "en-US";

  static String getNowPlayingMovies = "/movie/now_playing";
  static String getPopularMovies = "/movie/popular";
  static String getGenres = "/genre/movie/list";
  static String getMoviesByGenre = "/discover/movie";
  static String getMovieDetail = "/movie";
}