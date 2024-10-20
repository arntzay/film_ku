import 'package:film_ku/data/register_adapter.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genre_model.g.dart';

@JsonSerializable()
@HiveType(typeId: genreModelTypeId, adapterName: "GenreModelAdapter")
class GenreModel {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  GenreModel({
    this.id,
    this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => _$GenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
}
