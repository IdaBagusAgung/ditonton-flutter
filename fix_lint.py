import os

replacements = {
    'BASE_IMAGE_URL': 'baseImageUrl',
    'POPULAR_MOVIES_ROUTE': 'popularMoviesRoute',
    'TOP_RATED_ROUTE': 'topRatedRoute',
    'MOVIE_DETAIL_ROUTE': 'movieDetailRoute',
    'SEARCH_ROUTE': 'searchRoute',
    'ABOUT_ROUTE': 'aboutRoute',
    'WATCHLIST_MOVIES_ROUTE': 'watchlistMoviesRoute',
    'HOME_TV_ROUTE': 'homeTvRoute',
    'NOW_PLAYING_TV_ROUTE': 'nowPlayingTvRoute',
    'POPULAR_TV_ROUTE': 'popularTvRoute',
    'TOP_RATED_TV_ROUTE': 'topRatedTvRoute',
    'TV_DETAIL_ROUTE': 'tvDetailRoute',
    'SEARCH_TV_ROUTE': 'searchTvRoute',
    'WATCHLIST_TV_ROUTE': 'watchlistTvRoute',
    'SEASON_DETAIL_ROUTE': 'seasonDetailRoute',
    'RequestState.Empty': 'RequestState.empty',
    'RequestState.Loading': 'RequestState.loading',
    'RequestState.Loaded': 'RequestState.loaded',
    'RequestState.Error': 'RequestState.error',
}

def replace_in_file(filepath):
    with open(filepath, 'r') as f:
        content = f.read()
    
    new_content = content
    for k, v in replacements.items():
        new_content = new_content.replace(k, v)
        
    # Also we need to replace the enum definition itself, which is just 'Empty,', 'Loading,', 'Loaded,', 'Error,' in state_enum.dart
    if filepath.endswith('state_enum.dart'):
        new_content = new_content.replace('Empty,', 'empty,')
        new_content = new_content.replace('Loading,', 'loading,')
        new_content = new_content.replace('Loaded,', 'loaded,')
        new_content = new_content.replace('Error,', 'error,')
        new_content = new_content.replace('Empty}', 'empty}')
        new_content = new_content.replace('Loading}', 'loading}')
        new_content = new_content.replace('Loaded}', 'loaded}')
        new_content = new_content.replace('Error}', 'error}')
        
    if new_content != content:
        with open(filepath, 'w') as f:
            f.write(new_content)
        print(f"Updated {filepath}")

for root, _, files in os.walk('.'):
    for f in files:
        if f.endswith('.dart'):
            replace_in_file(os.path.join(root, f))
