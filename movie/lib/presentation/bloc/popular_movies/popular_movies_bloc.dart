import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getpopularmovies;

  PopularMoviesBloc(this._getpopularmovies) : super(PopularMoviesEmpty()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());
      final result = await _getpopularmovies.execute();
      result.fold(
        (failure) => emit(PopularMoviesError(failure.message)),
        (data) => emit(PopularMoviesHasData(data)),
      );
    });
  }
}
