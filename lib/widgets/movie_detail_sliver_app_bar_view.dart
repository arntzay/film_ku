import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_ku/data/api/http_config.dart';
import 'package:film_ku/data/model/movie_model.dart';
import 'package:film_ku/resources/colors.dart';
import 'package:flutter/material.dart';

class MovieDetailSliverAppBarView extends StatelessWidget {
  final MovieModel? movieDetail;

  MovieDetailSliverAppBarView({required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 360,
      backgroundColor: kDetailPageBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            MovieBackgroundImageView(
              imageUrl: movieDetail?.backdropPath ?? "",
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.4),
                      kDetailPageBackgroundColor,
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                // color: Colors.blue,
                child: Column(
                  children: [
                    AppBarWithBackButtonView(title: movieDetail?.title ?? ""),
                    SizedBox(height: 16),
                    MoviePosterView(
                      imageUrl: movieDetail?.backdropPath ?? "",
                    ),
                    SizedBox(height: 16),
                    MovieInfoView(movieModel: movieDetail),
                    SizedBox(height: 16),
                    RatingView(
                      rating: movieDetail?.rating ?? "",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingView extends StatelessWidget {
  final String rating;

  RatingView({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: IconAndLabelView(
        iconData: Icons.star,
        label: rating,
        color: kOrangeColor,
      ),
    );
  }
}

class MovieInfoView extends StatelessWidget {
  final MovieModel? movieModel;

  MovieInfoView({required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconAndLabelView(
          iconData: Icons.calendar_month,
          label: movieModel?.releaseYear ?? "",
        ),
        DividerView(),
        IconAndLabelView(
          iconData: Icons.access_time_filled_rounded,
          label: "${movieModel?.runtime} Minutes",
        ),
        DividerView(),
        IconAndLabelView(
          iconData: Icons.local_movies,
          label: movieModel?.firstGenre ?? "",
        ),
      ],
    );
  }
}

class DividerView extends StatelessWidget {
  const DividerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 20,
        width: 1,
        color: kMovieInfoTextColor,
      ),
    );
  }
}

class IconAndLabelView extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Color color;

  IconAndLabelView({
    required this.iconData,
    required this.label,
    this.color = kMovieInfoTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          color: color,
          size: 20,
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class MoviePosterView extends StatelessWidget {
  final String imageUrl;

  MoviePosterView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return imageUrl.isEmpty
        ? Container(
            width: 150,
            height: 200,
            child: Center(
              child: CircularProgressIndicator(color: kHighlightColor),
            ),
          )
        : CachedNetworkImage(
            imageUrl: "${HttpConfig.imageBaseUrl}$imageUrl",
            width: 150,
            height: 200,
            imageBuilder: (context, imageProvider) {
              return Container(
                width: 150,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 4,
                      spreadRadius: 2,
                      offset: Offset(1, 4),
                    ),
                  ],
                ),
              );
            },
            progressIndicatorBuilder: (context, url, progress) {
              return Center(
                child: CircularProgressIndicator(color: kHighlightColor),
              );
            },
            errorWidget: (context, url, error) {
              return Center(
                child: CircularProgressIndicator(color: kHighlightColor),
              );
            },
          );
    // return Container(
    //   width: 150,
    //   height: 200,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(8),
    //     image: DecorationImage(
    //       fit: BoxFit.cover,
    //       image: CachedNetworkImageProvider(
    //         imageUrl,
    //       ),
    //     ),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.4),
    //         blurRadius: 4,
    //         spreadRadius: 2,
    //         offset: Offset(1, 4),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class AppBarWithBackButtonView extends StatelessWidget {
  final String title;

  AppBarWithBackButtonView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          AppBarIconView(
            iconData: Icons.arrow_back_ios,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(width: 16),
          AppBarIconView(
            iconData: Icons.favorite_border_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class AppBarIconView extends StatelessWidget {
  final IconData iconData;
  final Function onTap;

  AppBarIconView({
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onTap();
      },
      icon: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }
}

class MovieBackgroundImageView extends StatelessWidget {
  final String imageUrl;

  MovieBackgroundImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    print("Image URL is ====> $imageUrl");
    return Positioned.fill(
      /// tenary operator
      child: imageUrl.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: kHighlightColor,
              ),
            )
          : CachedNetworkImage(
              imageUrl: "${HttpConfig.imageBaseUrl}$imageUrl",
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) {
                return Center(
                  child: CircularProgressIndicator(color: kHighlightColor),
                );
              },
              errorWidget: (context, url, error) {
                return Center(
                  child: CircularProgressIndicator(color: kHighlightColor),
                );
              },
            ),
    );
  }
}
