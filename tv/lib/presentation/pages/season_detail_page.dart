import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/season_detail/season_detail_bloc.dart';
import 'package:tv/presentation/bloc/season_detail/season_detail_event.dart';
import 'package:tv/presentation/bloc/season_detail/season_detail_state.dart';

class SeasonDetailArguments {
  final int tvId;
  final int seasonNumber;

  SeasonDetailArguments({required this.tvId, required this.seasonNumber});
}

class SeasonDetailPage extends StatefulWidget {
  final int tvId;
  final int seasonNumber;

  const SeasonDetailPage({
    super.key,
    required this.tvId,
    required this.seasonNumber,
  });

  @override
  _SeasonDetailPageState createState() => _SeasonDetailPageState();
}

class _SeasonDetailPageState extends State<SeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SeasonDetailBloc>().add(
            FetchSeasonDetail(widget.tvId, widget.seasonNumber),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Season ${widget.seasonNumber}'),
      ),
      body: BlocBuilder<SeasonDetailBloc, SeasonDetailState>(
        builder: (context, state) {
          if (state is SeasonDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeasonDetailHasData) {
            final season = state.seasonDetail;
            return ListView.builder(
              itemCount: season.episodes.length,
              itemBuilder: (context, index) {
                final episode = season.episodes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      episode.stillPath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(8),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                                width: 120,
                                height: 180,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            )
                          : Container(
                              width: 120,
                              height: 180,
                              color: Colors.grey[850],
                              child: Icon(Icons.image, size: 50),
                            ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${episode.episodeNumber}. ${episode.name}',
                                style: kHeading6,
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    episode.voteAverage.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                episode.overview,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is SeasonDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
