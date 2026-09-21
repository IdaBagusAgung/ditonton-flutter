import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/common/state_enum.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getDetail;
  final GetMovieRecommendations getRecommendations;
  final GetWatchListStatus getWatchlistStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getDetail,
    required this.getRecommendations,
    required this.getWatchlistStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailState.initial()) {
    on<FetchMovieDetail>((event, emit) async {
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
