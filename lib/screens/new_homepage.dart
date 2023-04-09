import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/movie.dart';



class NewHome extends StatelessWidget {
  final Movie movie;
  final GlobalKey backgroungImageKey = GlobalKey();
   NewHome({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
          aspectRatio: 16/9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Stack(
              children: [
                CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: movie.poster_path,
                    key: backgroungImageKey,
                    fit: BoxFit.cover,
                ),
               Positioned.fill(child: DecoratedBox(decoration: BoxDecoration(
                 gradient: LinearGradient(colors: [
                   Colors.transparent,
                   Colors.black.withOpacity(0.7),
                 ],
                 begin: Alignment.topCenter,
                 end: Alignment.bottomCenter,
                 stops: const [0.6, 0.95]
                 )
               ))) ,
                Column(
                 children: [
                   Text(movie.title),
                   Text(movie.overview)
                 ],
                )
              ],
            ),
          )
      ),
    );
  }
}
