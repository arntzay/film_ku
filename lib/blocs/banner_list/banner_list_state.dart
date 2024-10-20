part of 'banner_list_bloc.dart';

enum BannerListStatus {
  loading,
  success,
  error,
}

class BannerListState {
  BannerListStatus bannerListStatus;
  List<MovieModel>? movieList;
  String? error;

  BannerListState({
    required this.bannerListStatus,
    this.movieList,
    this.error,
  });

  BannerListState copyWith({
    required BannerListStatus bannerListStatus,
    List<MovieModel>? movieList,
    String? error,
  }) {
    return BannerListState(
      bannerListStatus: bannerListStatus,
      movieList: movieList ?? this.movieList,
      error: error ?? this.error,
    );
  }
}
