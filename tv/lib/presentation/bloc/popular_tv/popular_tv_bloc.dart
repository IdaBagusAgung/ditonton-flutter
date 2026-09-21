import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTVBloc extends Bloc<PopularTVEvent, PopularTVState> {
  final GetPopularTV _getpopulartv;

  PopularTVBloc(this._getpopulartv) : super(PopularTVEmpty()) {
    on<FetchPopularTV>((event, emit) async {
      emit(PopularTVLoading());
      final result = await _getpopulartv.execute();
      result.fold(
        (failure) => emit(PopularTVError(failure.message)),
        (data) => emit(PopularTVHasData(data)),
      );
    });
  }
}
