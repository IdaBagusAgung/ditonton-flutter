import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/episode.dart';

class SeasonDetail extends Equatable {
  final int id;
  final String? airDate;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final List<Episode> episodes;

  const SeasonDetail({
    required this.id,
    required this.airDate,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodes,
  });

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
