import 'package:film_ku/data/model/genre_model.dart';
import 'package:film_ku/data/register_adapter.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
@HiveType(typeId: movieModelTypeId, adapterName: "MovieModelAdapter")
class MovieModel {
  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "backdrop_path")
  @HiveField(1)
  String? backdropPath;

  @JsonKey(name: "genre_ids")
  @HiveField(2)
  List<int>? genreIds;

  @JsonKey(name: "id")
  @HiveField(3)
  int? id;

  @JsonKey(name: "original_language")
  @HiveField(4)
  String? originalLanguage;

  @JsonKey(name: "original_title")
  @HiveField(5)
  String? originalTitle;

  @JsonKey(name: "overview")
  @HiveField(6)
  String? overview;

  @JsonKey(name: "popularity")
  @HiveField(7)
  double? popularity;

  @JsonKey(name: "poster_path")
  @HiveField(8)
  String? posterPath;

  @JsonKey(name: "release_date")
  @HiveField(9)
  String? releaseDate;

  @JsonKey(name: "title")
  @HiveField(10)
  String? title;

  @JsonKey(name: "video")
  @HiveField(11)
  bool? video;

  @JsonKey(name: "vote_average")
  @HiveField(12)
  double? voteAverage;

  @JsonKey(name: "vote_count")
  @HiveField(13)
  int? voteCount;

  @JsonKey(name: "runtime")
  @HiveField(14)
  int? runtime;

  @JsonKey(name: "genres")
  @HiveField(15)
  List<GenreModel>? genreList;

  MovieModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.runtime,
    this.genreList,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  /// getter method - 3 parts
  /// return type, get, method name
  String get releaseYear {
    if(releaseDate == null) {
      return "";
    }
    return releaseDate?.split("-").first ?? "";
  }

  /// get first genre
  String get firstGenre {
    if(genreList != null && (genreList?.isNotEmpty ?? false)) {
      return genreList?.first.name ?? "";
    }

    return "";
  }

  /// get rating
  String get rating {
    if(voteAverage != null) {
      return voteAverage?.toStringAsFixed(1) ?? "";
    }

    return "";
  }
}
