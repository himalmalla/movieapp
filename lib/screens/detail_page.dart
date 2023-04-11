import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newmovieapp/screens/movie_video.dart';
import '../model/movie.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;
  DetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ..._buildbackground(context, movie),
          _buildmovieButton(context),
          Positioned(
              bottom: 60,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      icon: const Icon(Icons.watch_later),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15.0),
                        primary: Color(0xFFFF7272),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.425, 65),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: () {},
                      label: const Text('Add to Watchlist')),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.movie),
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        padding: const EdgeInsets.all(15.0),
                        primary: Colors.green,
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.425, 65),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: () {
                        Get.to(MovieVideo(movie));
                      },
                      label: const Text('Watch Trailer'))
                ],
              ))
        ],
      ),
    );
  }

  Positioned _buildmovieButton(BuildContext context) {
    return Positioned(
      bottom: 150,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(movie.title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    height: 1.75,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.redAccent)),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.overview,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(height: 1.75, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'IMDB Rating: ${movie.vote_average}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(width: 5,),
                  const Icon(Icons.star, color: Colors.yellowAccent, size: 19),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildbackground(context, movie) {
    return [
      Container(
        height: double.infinity,
        color: Color(0xff000B49),
      ),
      CachedNetworkImage(
          imageUrl: movie.poster_path,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          fit: BoxFit.cover),
      const Positioned.fill(
          child: DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Color(0xff000B49),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.3, 0.5])))),
    ];
  }
}
