import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newmovieapp/common_widgets/video_player_widget.dart';
import 'package:newmovieapp/providers/movie_image_provider.dart';
import 'package:newmovieapp/providers/video_provider.dart';
import '../model/movie.dart';

class MovieVideo extends StatelessWidget {
  final Movie movie;
  MovieVideo(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff354249),
        body: Consumer(
            builder: (context, ref, child) {
      final videoData = ref.watch(videoProvider(movie.id));
      final imageData = ref.watch(imageProvider(movie.id));
      return Center(
        child: ListView(
          children: [
            videoData.when(
                data: (data) {
                  return data.isEmpty ?  const Center(child: Text('No videos were found')): Container(
                    height: 245,
                    child: PlayVideoFromNetwork(
                      videoKey: data,
                    ),
                  );
                },
                error: (err, s) => Text('$err'),
                loading: () => Container()),
          ],

        ),
      );
    }));
  }
}
