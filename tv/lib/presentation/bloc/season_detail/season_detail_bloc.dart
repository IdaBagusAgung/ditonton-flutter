import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/usecases/get_tv_season_detail.dart';
import 'season_detail_event.dart';
import 'season_detail_state.dart';

class SeasonDetailBloc extends Bloc<SeasonDetailEvent, SeasonDetailState> {
  final GetTVSeasonDetail getSeasonDetail;

  SeasonDetailBloc(this.getSeasonDetail) : super(SeasonDetailEmpty()) {
    on<FetchSeasonDetail>((event, emit) async {
      emit(SeasonDetailLoading());
      final result = await getSeasonDetail.execute(event.tvId, event.seasonNumber);
      result.fold(
        (failure) {
          emit(SeasonDetailError(failure.message));
        },
        (data) {
          emit(SeasonDetailHasData(data));
        },
      );
    });
  }
}
