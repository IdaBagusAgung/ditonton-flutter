import 'package:tv/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  final int id;
  final String name;
  final String overview;
  final int episodeNumber;
  final String? stillPath;
  final double voteAverage;

  const EpisodeModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.episodeNumber,
    required this.stillPath,
    required this.voteAverage,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        id: json["id"],
        name: json["name"] ?? '',
        overview: json["overview"] ?? '',
        episodeNumber: json["episode_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "episode_number": episodeNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
      };

  Episode toEntity() {
    return Episode(
      id: id,
      name: name,
      overview: overview,
      episodeNumber: episodeNumber,
      stillPath: stillPath,
      voteAverage: voteAverage,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        episodeNumber,
        stillPath,
        voteAverage,
      ];
}
