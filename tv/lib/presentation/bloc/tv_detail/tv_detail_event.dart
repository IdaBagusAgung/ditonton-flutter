part of 'tv_detail_bloc.dart';

abstract class TVDetailEvent extends Equatable {
  const TVDetailEvent();
  @override
  List<Object> get props => [];
}

class FetchTVDetail extends TVDetailEvent {
  final int id;
  const FetchTVDetail(this.id);
  @override
  List<Object> get props => [id];
}

class AddWatchlist extends TVDetailEvent {
  final TVDetail detail;
  const AddWatchlist(this.detail);
  @override
  List<Object> get props => [detail];
}

class RemoveFromWatchlist extends TVDetailEvent {
  final TVDetail detail;
  const RemoveFromWatchlist(this.detail);
  @override
  List<Object> get props => [detail];
}

class LoadWatchlistStatus extends TVDetailEvent {
  final int id;
  const LoadWatchlistStatus(this.id);
  @override
  List<Object> get props => [id];
}
