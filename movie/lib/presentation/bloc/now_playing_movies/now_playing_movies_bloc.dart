import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getnowplayingmovies;

  NowPlayingMoviesBloc(this._getnowplayingmovies) : super(NowPlayingMoviesEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(NowPlayingMoviesLoading());
      final result = await _getnowplayingmovies.execute();
      result.fold(
        (failure) => emit(NowPlayingMoviesError(failure.message)),
        (data) => emit(NowPlayingMoviesHasData(data)),
      );
    });
  }
}
