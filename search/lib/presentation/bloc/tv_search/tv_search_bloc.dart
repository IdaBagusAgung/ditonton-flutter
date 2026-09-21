import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:rxdart/rxdart.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TVSearchBloc extends Bloc<TVSearchEvent, TVSearchState> {
  final SearchTV _search;

  TVSearchBloc(this._search) : super(TVSearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(TVSearchLoading());
      final result = await _search.execute(query);
      result.fold(
        (failure) => emit(TVSearchError(failure.message)),
        (data) => emit(TVSearchHasData(data)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
