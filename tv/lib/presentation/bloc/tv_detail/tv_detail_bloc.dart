import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/common/state_enum.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/save_tv_watchlist.dart';
import 'package:tv/domain/usecases/remove_tv_watchlist.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TVDetailBloc extends Bloc<TVDetailEvent, TVDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVDetail getDetail;
  final GetTVRecommendations getRecommendations;
  final GetWatchlistTVStatus getWatchlistStatus;
  final SaveTVWatchlist saveWatchlist;
  final RemoveTVWatchlist removeWatchlist;

  TVDetailBloc({
    required this.getDetail,
    required this.getRecommendations,
    required this.getWatchlistStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TVDetailState.initial()) {
    on<FetchTVDetail>((event, emit) async {
      emit(state.copyWith(detailState: RequestState.Loading));
      final detailResult = await getDetail.execute(event.id);
      final recommendationResult = await getRecommendations.execute(event.id);

      detailResult.fold(
        (failure) => emit(state.copyWith(
          detailState: RequestState.Error,
          message: failure.message,
        )),
        (detail) {
          emit(state.copyWith(
            recommendationState: RequestState.Loading,
            detailState: RequestState.Loaded,
            detail: detail,
          ));
          recommendationResult.fold(
            (failure) => emit(state.copyWith(
              recommendationState: RequestState.Error,
              message: failure.message,
            )),
            (recommendations) => emit(state.copyWith(
              recommendationState: RequestState.Loaded,
              recommendations: recommendations,
            )),
          );
        },
      );
    });

    on<AddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.detail);
      result.fold(
        (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
        (successMessage) => emit(state.copyWith(watchlistMessage: successMessage)),
      );
      add(LoadWatchlistStatus(event.detail.id));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.detail);
      result.fold(
        (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
        (successMessage) => emit(state.copyWith(watchlistMessage: successMessage)),
      );
      add(LoadWatchlistStatus(event.detail.id));
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchlistStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
