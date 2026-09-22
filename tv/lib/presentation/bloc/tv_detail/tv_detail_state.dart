part of 'tv_detail_bloc.dart';

class TVDetailState extends Equatable {
  final RequestState detailState;
  final TVDetail? detail;
  final RequestState recommendationState;
  final List<TV> recommendations;
  final bool isAddedToWatchlist;
  final String watchlistMessage;
  final String message;

  const TVDetailState({
    required this.detailState,
    this.detail,
    required this.recommendationState,
    required this.recommendations,
    required this.isAddedToWatchlist,
    required this.watchlistMessage,
    required this.message,
  });

  TVDetailState copyWith({
    RequestState? detailState,
    TVDetail? detail,
    RequestState? recommendationState,
    List<TV>? recommendations,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
    String? message,
  }) {
    return TVDetailState(
      detailState: detailState ?? this.detailState,
      detail: detail ?? this.detail,
      recommendationState: recommendationState ?? this.recommendationState,
      recommendations: recommendations ?? this.recommendations,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      message: message ?? this.message,
    );
  }

  factory TVDetailState.initial() {
    return const TVDetailState(
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
