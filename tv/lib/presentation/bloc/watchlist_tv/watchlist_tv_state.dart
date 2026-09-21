part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTVState extends Equatable {
  const WatchlistTVState();
  
  @override
  List<Object> get props => [];
}

class WatchlistTVEmpty extends WatchlistTVState {}
class WatchlistTVLoading extends WatchlistTVState {}
class WatchlistTVError extends WatchlistTVState {
  final String message;
  const WatchlistTVError(this.message);
  @override
  List<Object> get props => [message];
}
class WatchlistTVHasData extends WatchlistTVState {
  final List<TV> result;
  const WatchlistTVHasData(this.result);
  @override
  List<Object> get props => [result];
}
