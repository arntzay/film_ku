import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_ku/data/api/http_config.dart';
import 'package:film_ku/data/model/movie_model.dart';
import 'package:film_ku/resources/colors.dart';
import 'package:flutter/material.dart';

class MovieView extends StatelessWidget {
  final MovieModel? movieModel;
  final Function onTapMovie;

  MovieView({
    required this.movieModel,
    required this.onTapMovie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapMovie();
      },
      child: Container(
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl:
                    "${HttpConfig.imageBaseUrl}${movieModel?.backdropPath}",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) {
                  return Center(
                    child: CircularProgressIndicator(color: kHighlightColor),
                  );
                },
                errorWidget: (context, url, error) {
                  return Center(
                    child: Icon(
                      Icons.info,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
              // child: Image.network(
              //   "${HttpConfig.imageBaseUrl}${movieModel?.backdropPath}",
              //   height: 200,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
            ),
            SizedBox(height: 12),
            Text(
              movieModel?.title ?? "",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  "${movieModel?.voteAverage?.toStringAsFixed(1)}/10 IMDb",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
