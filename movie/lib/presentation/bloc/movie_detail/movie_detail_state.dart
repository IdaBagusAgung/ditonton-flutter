part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final RequestState detailState;
  final MovieDetail? detail;
  final RequestState recommendationState;
  final List<Movie> recommendations;
  final bool isAddedToWatchlist;
  final String watchlistMessage;
  final String message;

  const MovieDetailState({
    required this.detailState,
    this.detail,
    required this.recommendationState,
    required this.recommendations,
    required this.isAddedToWatchlist,
    required this.watchlistMessage,
    required this.message,
  });

  MovieDetailState copyWith({
    RequestState? detailState,
    MovieDetail? detail,
    RequestState? recommendationState,
    List<Movie>? recommendations,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
    String? message,
  }) {
    return MovieDetailState(
      detailState: detailState ?? this.detailState,
      detail: detail ?? this.detail,
      recommendationState: recommendationState ?? this.recommendationState,
      recommendations: recommendations ?? this.recommendations,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      message: message ?? this.message,
    );
  }

  factory MovieDetailState.initial() {
    return const MovieDetailState(
      detailState: RequestState.empty,
      detail: null,
      recommendationState: RequestState.empty,
      recommendations: [],
      isAddedToWatchlist: false,
      watchlistMessage: '',
      message: '',
    );
  }

  @override
  List<Object?> get props => [
        detailState,
        detail,
        recommendationState,
        recommendations,
        isAddedToWatchlist,
        watchlistMessage,
        message,
      ];
}
