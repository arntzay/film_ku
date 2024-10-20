import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:film_ku/data/api/custom_failure.dart';
import 'package:film_ku/data/model/movie_model.dart';
import 'package:film_ku/domain/usecases/movie_use_case.dart';

part 'banner_list_event.dart';
part 'banner_list_state.dart';

class BannerListBloc extends Bloc<BannerListEvent, BannerListState> {
  /// Use Cases
  MovieUseCase movieUseCase = MovieUseCase();

  /// Boxes


  BannerListBloc()
      : super(BannerListState(bannerListStatus: BannerListStatus.loading)) {
    on<GetBannerList>(_getBannerList);
  }

  FutureOr<void> _getBannerList(
    GetBannerList event,
    Emitter<BannerListState> emit,
  ) async {
    final result = await movieUseCase.getNowPlayingMovies();

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          var errorState = state.copyWith(
            bannerListStatus: BannerListStatus.error,
            error: "Please check your internet connection.",
          );
          emit(errorState);
        }

        if (error is ServerFailure) {
          /// server failure error message emit
          var errorState = state.copyWith(
            bannerListStatus: BannerListStatus.error,
            error: error.error.toString(),
          );
          emit(errorState);
        }
      },
      (movieList) {
        movieList = movieList.getRange(0, 5).toList();
        var successState = state.copyWith(
          bannerListStatus: BannerListStatus.success,
          movieList: movieList,
        );
        emit(successState);
      },
    );
  }
}
