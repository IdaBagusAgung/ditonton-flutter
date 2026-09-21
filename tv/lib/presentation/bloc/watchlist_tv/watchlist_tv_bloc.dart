import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTVBloc extends Bloc<WatchlistTVEvent, WatchlistTVState> {
  final GetWatchlistTV _getwatchlisttv;

  WatchlistTVBloc(this._getwatchlisttv) : super(WatchlistTVEmpty()) {
    on<FetchWatchlistTV>((event, emit) async {
      emit(WatchlistTVLoading());
      final result = await _getwatchlisttv.execute();
      result.fold(
        (failure) => emit(WatchlistTVError(failure.message)),
        (data) => emit(WatchlistTVHasData(data)),
      );
    });
  }
}
