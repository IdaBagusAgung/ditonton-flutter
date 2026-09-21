part of 'tv_search_bloc.dart';

abstract class TVSearchState extends Equatable {
  const TVSearchState();
  
  @override
  List<Object> get props => [];
}

class TVSearchEmpty extends TVSearchState {}
class TVSearchLoading extends TVSearchState {}
class TVSearchError extends TVSearchState {
  final String message;
  const TVSearchError(this.message);
  @override
  List<Object> get props => [message];
}
class TVSearchHasData extends TVSearchState {
  final List<TV> result;
  const TVSearchHasData(this.result);
  @override
  List<Object> get props => [result];
}
