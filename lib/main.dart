import 'package:core/common/routes.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:about/presentation/pages/about_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:search/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:tv/presentation/bloc/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/season_detail/season_detail_bloc.dart';
import 'package:search/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/pages/season_detail_page.dart';
import 'package:search/presentation/pages/search_tv_page.dart';
import 'package:tv/presentation/pages/watchlist_tv_page.dart';
import 'package:tv/presentation/pages/now_playing_tv_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  } catch (e) {
    print("Firebase initialization failed: $e");
  }
  try {
    await di.init();
  } catch (e, stacktrace) {
    print("Initialization failed: $e\n$stacktrace");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<NowPlayingMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<MovieSearchBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<NowPlayingTVBloc>()),
        BlocProvider(create: (_) => di.locator<TVDetailBloc>()),
        BlocProvider(create: (_) => di.locator<TVSearchBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedTVBloc>()),
        BlocProvider(create: (_) => di.locator<PopularTVBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistTVBloc>()),
        BlocProvider(create: (_) => di.locator<SeasonDetailBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
          drawerTheme: kDrawerTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [
          routeObserver,
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case popularMoviesRoute:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case topRatedRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case movieDetailRoute:
              final id = settings.arguments as int? ?? 0;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case searchRoute:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case watchlistMoviesRoute:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case homeTvRoute:
              return MaterialPageRoute(builder: (_) => HomeTVPage());
            case nowPlayingTvRoute:
              return CupertinoPageRoute(builder: (_) => NowPlayingTVPage());
            case popularTvRoute:
              return CupertinoPageRoute(builder: (_) => PopularTVPage());
            case topRatedTvRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedTVPage());
            case tvDetailRoute:
              final id = settings.arguments as int? ?? 0;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case searchTvRoute:
              return CupertinoPageRoute(builder: (_) => SearchTVPage());
            case watchlistTvRoute:
              return MaterialPageRoute(builder: (_) => WatchlistTVPage());
            case seasonDetailRoute:
              final args = settings.arguments as SeasonDetailArguments;
              return MaterialPageRoute(
                builder: (_) => SeasonDetailPage(
                  tvId: args.tvId,
                  seasonNumber: args.seasonNumber,
                ),
              );
            case aboutRoute:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(child: Text('Page not found :(')),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
