// Stateless
import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_ku/blocs/banner_list/banner_list_bloc.dart';
import 'package:film_ku/data/api/http_config.dart';
import 'package:film_ku/data/boxes/banner_box.dart';
import 'package:film_ku/data/boxes/recmmended_movies_box.dart';
import 'package:film_ku/data/model/genre_model.dart';
import 'package:film_ku/data/model/movie_model.dart';
import 'package:film_ku/domain/usecases/movie_use_case.dart';
import 'package:film_ku/pages/movie_detail_page.dart';
import 'package:film_ku/resources/colors.dart';
import 'package:film_ku/viewitems/movie_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BannerListBloc()..add(GetBannerList()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const Icon(
            Icons.menu,
          ),
          title: const Text(
            "Movie",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: const [
            Icon(
              Icons.notifications,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BannerSectionView(),
              const SizedBox(height: 16),
              // RecommendedForYouSectionView(popularMovies: popularMovies ?? []),
              // const SizedBox(height: 16),
              // MoviesByCategorySectionView(
              //   genreList: genreList ?? [],
              //   moviesByGenre: moviesByGenre ?? [],
              //   onTapGenre: (index) {
              //     /// get movies by genre
              //     List<GenreModel> genres = genreList ?? [];
              //     int genreId = genres[index].id ?? 0;
              //
              //     movieUseCase.getMoviesByGenre(genreId).then((moviesByGenre) {
              //       this.moviesByGenre = moviesByGenre;
              //       setState(() {});
              //     });
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoviesByCategorySectionView extends StatelessWidget {
  final List<GenreModel> genreList;
  final List<MovieModel> moviesByGenre;
  final Function(int) onTapGenre;

  MoviesByCategorySectionView({
    required this.genreList,
    required this.moviesByGenre,
    required this.onTapGenre,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleView(title: "Categories"),
        const SizedBox(height: 16),
        CategoryTabBarView(
          genreList: genreList,
          onTapGenre: (index) {
            onTapGenre(index);
          },
        ),
        const SizedBox(height: 16),
        HorizontalMovieListView(
          movies: moviesByGenre,
        ),
      ],
    );
  }
}

class CategoryTabBarView extends StatelessWidget {
  final List<GenreModel> genreList;
  final Function(int) onTapGenre;

  CategoryTabBarView({
    required this.genreList,
    required this.onTapGenre,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: genreList.length,
      child: TabBar(
        isScrollable: true,
        dividerHeight: 0,
        indicatorColor: kHighlightColor,
        tabAlignment: TabAlignment.start,
        labelColor: kHighlightColor,
        onTap: (int index) {
          onTapGenre(index);
        },
        tabs: genreList.map((genre) {
          return Tab(
            text: genre.name ?? "",
          );
        }).toList(),
      ),
    );
  }
}

class RecommendedForYouSectionView extends StatelessWidget {
  final List<MovieModel> popularMovies;

  RecommendedForYouSectionView({required this.popularMovies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleView(title: "Recommended for you"),
        const SizedBox(height: 16),
        HorizontalMovieListView(movies: popularMovies),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final List<MovieModel> movies;

  HorizontalMovieListView({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieView(
            movieModel: movies[index],
            onTapMovie: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MovieDetailPage(movieId: movies[index].id ?? 0),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 16);
        },
      ),
    );
  }
}

class TitleView extends StatelessWidget {
  final String title;

  TitleView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const Text(
            "See All",
            style: TextStyle(
              color: kHighlightColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerListBloc, BannerListState>(
      builder: (context, state) {
        /// loading
        if (state.bannerListStatus == BannerListStatus.loading) {
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1 / 3,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        /// success
        if (state.bannerListStatus == BannerListStatus.success) {
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1 / 3,
                child: PageView(
                  onPageChanged: (int pageIndex) {
                    setState(() {
                      currentIndex = pageIndex;
                    });
                    print("Current Index =====> $currentIndex");
                  },
                  children: state.movieList?.map((movieModel) {
                    return BannerImageView(movieModel: movieModel);
                  }).toList() ?? [],
                ),
              ),
              const SizedBox(height: 12),

              /// Page Indicator
              Visibility(
                visible: state.movieList?.isNotEmpty ?? false,
                child: AnimatedSmoothIndicator(
                  activeIndex: currentIndex,
                  count: state.movieList?.length ?? 0,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Color.fromRGBO(21, 205, 218, 1.0),
                  ),
                ),
              ),
            ],
          );
        }

        /// error
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1 / 3,
          child: Center(
            child: Text(
              state.error ?? "",
            ),
          ),
        );
      },
    );
  }
}

class BannerImageView extends StatelessWidget {
  final MovieModel? movieModel;

  BannerImageView({required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl:
                "${HttpConfig.imageBaseUrl}${movieModel?.backdropPath ?? ""}",
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movieModel?.title ?? "",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "On ${movieModel?.releaseDate}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

/// Image Type 2
/// Asset Image
/// Network Image
/// https://thanhnien.mediacdn.vn/Uploaded/dotuan/2022_11_10/1-5451.jpg
