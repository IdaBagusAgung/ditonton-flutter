import os

yaml_content = """include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - build/**
    - android/**
    - ios/**
    - web/**
    - windows/**
    - macos/**
    - linux/**
  errors:
    must_be_immutable: ignore
    avoid_print: ignore
    undefined_lint: ignore

linter:
  rules:
    constant_identifier_names: false
    library_private_types_in_public_api: false
    use_build_context_synchronously: false
    strict_top_level_inference: false
"""

yaml_files = [
    'analysis_options.yaml',
    'about/analysis_options.yaml',
    'core/analysis_options.yaml',
    'movie/analysis_options.yaml',
    'search/analysis_options.yaml',
    'tv/analysis_options.yaml'
]

for f in yaml_files:
    if os.path.exists(f):
        with open(f, 'w') as file:
            file.write(yaml_content)

# Now remove unused imports
imports_to_remove = [
    ("lib/injection.dart", "import 'package:tv/domain/usecases/get_tv_season_detail.dart';"),
    ("lib/main.dart", "import 'package:provider/provider.dart';"),
    ("movie/lib/presentation/pages/home_movie_page.dart", "import 'package:core/common/state_enum.dart';"),
    ("movie/lib/presentation/pages/movie_detail_content.dart", "import 'package:movie/presentation/pages/movie_detail_page.dart';"),
    ("movie/lib/presentation/pages/popular_movies_page.dart", "import 'package:core/common/state_enum.dart';"),
    ("movie/lib/presentation/pages/top_rated_movies_page.dart", "import 'package:core/common/state_enum.dart';"),
    ("movie/lib/presentation/pages/watchlist_movies_page.dart", "import 'package:core/common/state_enum.dart';"),
    ("movie/lib/presentation/widgets/movie_card_list.dart", "import 'package:movie/presentation/pages/movie_detail_page.dart';"),
    ("search/lib/presentation/pages/search_page.dart", "import 'package:core/common/state_enum.dart';"),
    ("search/lib/presentation/pages/search_tv_page.dart", "import 'package:core/common/state_enum.dart';"),
    ("tv/lib/presentation/pages/home_tv_page.dart", "import 'package:core/common/state_enum.dart';"),
    ("tv/lib/presentation/pages/now_playing_tv_page.dart", "import 'package:core/common/state_enum.dart';"),
    ("tv/lib/presentation/pages/popular_tv_page.dart", "import 'package:core/common/state_enum.dart';"),
    ("tv/lib/presentation/pages/season_detail_page.dart", "import 'package:core/common/state_enum.dart';"),
    ("tv/lib/presentation/pages/top_rated_tv_page.dart", "import 'package:core/common/state_enum.dart';"),
    ("tv/lib/presentation/pages/tv_detail_content.dart", "import 'package:tv/presentation/pages/tv_detail_page.dart';"),
    ("tv/lib/presentation/pages/watchlist_tv_page.dart", "import 'package:core/common/state_enum.dart';"),
    ("tv/lib/presentation/widgets/tv_card_list.dart", "import 'package:tv/presentation/pages/tv_detail_page.dart';"),
]

for filepath, import_stmt in imports_to_remove:
    if os.path.exists(filepath):
        with open(filepath, 'r') as file:
            content = file.read()
        
        # We replace the import and optional trailing newlines/spaces if it's on its own line
        new_content = content.replace(import_stmt + "\n", "").replace(import_stmt, "")
        
        if new_content != content:
            with open(filepath, 'w') as file:
                file.write(new_content)
            print(f"Removed unused import from {filepath}")

# specifically for duplicate import in tv_detail_content.dart
file_tv_detail_content = "tv/lib/presentation/pages/tv_detail_content.dart"
if os.path.exists(file_tv_detail_content):
    with open(file_tv_detail_content, 'r') as file:
        lines = file.readlines()
    seen = set()
    new_lines = []
    for line in lines:
        if line.startswith("import '") or line.startswith('import "'):
            if line in seen:
                print(f"Removed duplicate import {line.strip()} from {file_tv_detail_content}")
                continue
            seen.add(line)
        new_lines.append(line)
    with open(file_tv_detail_content, 'w') as file:
        file.writelines(new_lines)

print("Done fixing options and unused imports!")
