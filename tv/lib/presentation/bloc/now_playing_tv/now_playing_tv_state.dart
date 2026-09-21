part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTVState extends Equatable {
  const NowPlayingTVState();
  
  @override
  List<Object> get props => [];
}

class NowPlayingTVEmpty extends NowPlayingTVState {}
class NowPlayingTVLoading extends NowPlayingTVState {}
class NowPlayingTVError extends NowPlayingTVState {
  final String message;
  const NowPlayingTVError(this.message);
  @override
  List<Object> get props => [message];
}
class NowPlayingTVHasData extends NowPlayingTVState {
  final List<TV> result;
  const NowPlayingTVHasData(this.result);
  @override
  List<Object> get props => [result];
}
