import 'package:film_ku/data/register_adapter.dart';
import 'package:film_ku/data/repositories/movie_repository_impl.dart';
import 'package:film_ku/pages/bottom_nav_page.dart';
import 'package:film_ku/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  await Hive.initFlutter();
  await registerAdapters();
  runApp(const MyApp());

  MovieRepositoryImpl().getNowPlayingMovies();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BottomNavPage(),
    );
  }
}
