import 'package:film_ku/resources/colors.dart';
import 'package:flutter/material.dart';

class CastView extends StatelessWidget {
  const CastView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              "https://static.standard.co.uk/2022/05/19/02/bad19ba6eb50d698a3c57c10af945ec4Y29udGVudHNlYXJjaGFwaSwxNjUyOTYyMDc5-2.66909041.jpg?width=1200&height=1200&fit=crop",
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jon Watts",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Directors",
                  style: TextStyle(
                    color: kMovieInfoTextColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
