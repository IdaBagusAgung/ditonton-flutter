import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final int id;
  final String name;
  final String overview;
  final int episodeNumber;
  final String? stillPath;
  final double voteAverage;

  const Episode({
    required this.id,
    required this.name,
    required this.overview,
    required this.episodeNumber,
    required this.stillPath,
    required this.voteAverage,
  });

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
