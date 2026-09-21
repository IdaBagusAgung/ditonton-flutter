import 'package:equatable/equatable.dart';

class Season extends Equatable {
  final int id;
  final String? airDate;
  final int episodeCount;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  const Season({
    required this.id,
    required this.airDate,
    required this.episodeCount,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [
    id,
    airDate,
    episodeCount,
    name,
    overview,
    posterPath,
    seasonNumber,
  ];
}
