import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_content.dart';

class TVDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  const TVDetailPage({super.key, required this.id});

  @override
  _TVDetailPageState createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVDetailBloc>().add(FetchTVDetail(widget.id));
      context.read<TVDetailBloc>().add(LoadWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TVDetailBloc, TVDetailState>(
        listener: (context, state) {
          final message = state.watchlistMessage;
          if (message == TVDetailBloc.watchlistAddSuccessMessage ||
              message == TVDetailBloc.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          } else if (message.isNotEmpty) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(message),
                );
              },
            );
          }
        },
        listenWhen: (oldState, newState) {
          return oldState.watchlistMessage != newState.watchlistMessage &&
              newState.watchlistMessage != '';
        },
        builder: (context, state) {
          if (state.detailState == RequestState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.detailState == RequestState.Loaded) {
            final tv = state.detail!;
            return SafeArea(
              child: TVDetailContent(
                tv,
                state.recommendations,
                state.isAddedToWatchlist,
              ),
            );
          } else if (state.detailState == RequestState.Error) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
