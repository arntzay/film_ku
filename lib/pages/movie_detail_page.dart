import 'package:film_ku/data/boxes/movie_detail_box.dart';
import 'package:film_ku/data/model/genre_model.dart';
import 'package:film_ku/data/model/movie_model.dart';
import 'package:film_ku/domain/usecases/movie_use_case.dart';
import 'package:film_ku/resources/colors.dart';
import 'package:film_ku/viewitems/cast_view.dart';
import 'package:film_ku/viewitems/genre_view.dart';
import 'package:film_ku/widgets/movie_detail_sliver_app_bar_view.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  MovieDetailPage({required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  /// Use Case
  MovieUseCase movieUseCase = MovieUseCase();

  /// Boxes
  MovieDetailBox movieDetailBox = MovieDetailBox();

  /// States
  MovieModel? movieDetail;

  @override
  void initState() {
    /// Get Movie Detail From Database
    movieDetail = movieDetailBox.getMovieById(widget.movieId);
    setState(() {});

    /// Get Movie Detail From API
    movieUseCase.getMovieDetail(widget.movieId).then((movieDetail) {
      movieDetailBox.saveSingleMovie(movieDetail);
      this.movieDetail = movieDetail;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDetailPageBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: CustomScrollView(
        slivers: [
          MovieDetailSliverAppBarView(
            movieDetail: movieDetail,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 16),
                const MovieActionSectionView(),
                const SizedBox(height: 24),
                GenreAndDurationSectionView(
                    genreList: movieDetail?.genreList ?? []),
                const SizedBox(height: 30),
                StoryLineSectionView(storyLine: movieDetail?.overview ?? ""),
                const SizedBox(height: 30),
                const CastAndCrewSectionView(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CastAndCrewSectionView extends StatelessWidget {
  const CastAndCrewSectionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DetailPageTitleView(title: "Cast and Crew"),
        ),
        const SizedBox(height: 4),
        const HorizontalCastListView(),
      ],
    );
  }
}

class HorizontalCastListView extends StatelessWidget {
  const HorizontalCastListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const CastView();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 12);
        },
      ),
    );
  }
}

class StoryLineSectionView extends StatefulWidget {
  final String storyLine;

  StoryLineSectionView({required this.storyLine});

  @override
  State<StoryLineSectionView> createState() => _StoryLineSectionViewState();
}

class _StoryLineSectionViewState extends State<StoryLineSectionView> {
  bool isTextExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailPageTitleView(title: "Story Line"),
          const SizedBox(height: 12),
          // Text(
          //   storyLine.substring(0, 200),
          //   style: TextStyle(
          //     color: Colors.white,
          //     height: 1.7,
          //   ),
          // ),

          widget.storyLine.isEmpty
              ? const SizedBox.shrink()
              : widget.storyLine.length < 200
                  ? Text(
                      widget.storyLine,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        height: 1.7,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        isTextExpanded = !isTextExpanded;
                        setState(() {});
                      },
                      child: RichText(
                        text: TextSpan(
                          text: !isTextExpanded
                              ? widget.storyLine.substring(0, 200)
                              : widget.storyLine,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            height: 1.7,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  !isTextExpanded ? "... See More" : "See Less",
                              style: const TextStyle(
                                color: kHighlightColor,
                                decoration: TextDecoration.underline,
                                decorationColor: kHighlightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}

class DetailPageTitleView extends StatelessWidget {
  final String title;

  DetailPageTitleView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}

class GenreAndDurationSectionView extends StatelessWidget {
  final List<GenreModel> genreList;

  GenreAndDurationSectionView({required this.genreList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Wrap(
              spacing: 8,

              /// horizontal
              runSpacing: 8,

              /// vertical
              children: genreList.map((genreModel) {
                return GenreView(genre: genreModel);
              }).toList(),
            ),
          ),
          const SizedBox(width: 16),
          IconAndLabelView(
            iconData: Icons.access_time_rounded,
            label: "2h 13m",
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class MovieActionSectionView extends StatelessWidget {
  const MovieActionSectionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const PlayButtonView(),
        const SizedBox(width: 12),
        DownloadButtonView(
          iconColor: kOrangeColor,
          iconData: Icons.download_rounded,
        ),
        const SizedBox(width: 12),
        DownloadButtonView(
          iconColor: kHighlightColor,
          iconData: Icons.ios_share_outlined,
        ),
      ],
    );
  }
}

class DownloadButtonView extends StatelessWidget {
  final Color iconColor;
  final IconData iconData;

  DownloadButtonView({
    required this.iconColor,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: const BoxDecoration(
        color: kDownloadButtonBackgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: iconColor,
      ),
    );
  }
}

class PlayButtonView extends StatelessWidget {
  const PlayButtonView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: kOrangeColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            "Play",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
