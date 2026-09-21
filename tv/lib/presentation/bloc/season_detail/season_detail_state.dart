import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/season_detail.dart';

abstract class SeasonDetailState extends Equatable {
  const SeasonDetailState();

  @override
  List<Object> get props => [];
}

class SeasonDetailEmpty extends SeasonDetailState {}

class SeasonDetailLoading extends SeasonDetailState {}

class SeasonDetailHasData extends SeasonDetailState {
  final SeasonDetail seasonDetail;

  const SeasonDetailHasData(this.seasonDetail);

  @override
  List<Object> get props => [seasonDetail];
}

class SeasonDetailError extends SeasonDetailState {
  final String message;

  const SeasonDetailError(this.message);

  @override
  List<Object> get props => [message];
}
