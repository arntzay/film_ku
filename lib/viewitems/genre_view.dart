import 'package:film_ku/data/model/genre_model.dart';
import 'package:film_ku/resources/colors.dart';
import 'package:flutter/material.dart';

class GenreView extends StatelessWidget {
  final GenreModel? genre;

  GenreView({required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: kGenreBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        genre?.name ?? "",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
