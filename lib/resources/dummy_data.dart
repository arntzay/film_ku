import 'package:film_ku/pages/download_page.dart';
import 'package:film_ku/pages/home_page.dart';
import 'package:film_ku/pages/profile_page.dart';
import 'package:film_ku/pages/search_page.dart';
import 'package:flutter/material.dart';

List<String> categoryList = [
  "All",
  "Action",
  "Drama",
  "Romance",
  "Horror",
  "Comedy",
  "Science Fiction",
  "Documentary",
  "Animation",
  "Thriller",
];

List<Widget> pages = [
  HomePage(),
  SearchPage(),
  DownloadPage(),
  ProfilePage(),
];