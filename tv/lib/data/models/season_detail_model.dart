import 'package:tv/data/models/episode_model.dart';
import 'package:tv/domain/entities/season_detail.dart';
import 'package:equatable/equatable.dart';

class SeasonDetailModel extends Equatable {
  final int id;
  final String? airDate;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final List<EpisodeModel> episodes;

  const SeasonDetailModel({
    required this.id,
    required this.airDate,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodes,
  });

  factory SeasonDetailModel.fromJson(Map<String, dynamic> json) => SeasonDetailModel(
        id: json["_id"] is String ? 0 : (json["id"] ?? 0),
        airDate: json["air_date"],
        name: json["name"] ?? '',
        overview: json["overview"] ?? '',
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"] ?? 0,
        episodes: json["episodes"] != null
            ? List<EpisodeModel>.from(
                json["episodes"].map((x) => EpisodeModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "air_date": airDate,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
      };

  SeasonDetail toEntity() {
    return SeasonDetail(
      id: id,
      airDate: airDate,
      name: name,
      overview: overview,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
      episodes: episodes.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        airDate,
        name,
        overview,
        posterPath,
        seasonNumber,
        episodes,
      ];
}
