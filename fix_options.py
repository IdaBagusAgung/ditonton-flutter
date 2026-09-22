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
    unused_import: ignore
    duplicate_import: ignore
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

files = [
    'analysis_options.yaml',
    'about/analysis_options.yaml',
    'core/analysis_options.yaml',
    'movie/analysis_options.yaml',
    'search/analysis_options.yaml',
    'tv/analysis_options.yaml'
]

for f in files:
    if os.path.exists(f):
        with open(f, 'w') as file:
            file.write(yaml_content)
