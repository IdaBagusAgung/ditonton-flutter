import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTVBloc extends Bloc<TopRatedTVEvent, TopRatedTVState> {
  final GetTopRatedTV _gettopratedtv;

  TopRatedTVBloc(this._gettopratedtv) : super(TopRatedTVEmpty()) {
    on<FetchTopRatedTV>((event, emit) async {
      emit(TopRatedTVLoading());
      final result = await _gettopratedtv.execute();
      result.fold(
        (failure) => emit(TopRatedTVError(failure.message)),
        (data) => emit(TopRatedTVHasData(data)),
      );
    });
  }
}
