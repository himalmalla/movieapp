import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:newmovieapp/screens/detail_page.dart';
import '../api.dart';
import '../constants/const_widgets.dart';
import '../constants/enum.dart';
import '../providers/movie_provider.dart';


class TabBarWidget extends StatelessWidget {
  final CategoryType categoryType;
  final String pageKey;
  const TabBarWidget(
      {super.key, required this.categoryType, required this.pageKey});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      child: Container(),
        connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
    ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected ? _buildConsumer(connected) : categoryType == CategoryType.Now_Playing ? _buildConsumer(connected):
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(child: Text('No connection', style: TextStyle(color: Colors.white),)),
            ],
          );
        }
    );
  }

  Consumer _buildConsumer(bool connect) {
    return Consumer(builder: (context, ref, child) {
          final apiPath = categoryType == CategoryType.Now_Playing
              ? Api.nowPlaying
              : categoryType == CategoryType.Popular
              ? Api.popularMovie
              : categoryType == CategoryType.Top_Rated
              ? Api.topRatedMovie
              : Api.upComingMovie;
          final movieData = ref.watch(movieProvider(apiPath));
          if (movieData.isLoad) {
            return const Center(
              child: LinearProgressIndicator(
                color: Colors.red,
              ),
            );
          } else if (movieData.isError) {
            return Center(
              child: Text(movieData.errMessage),
            );
          } else {
            return NotificationListener(
              onNotification: (ScrollEndNotification onNotification) {
                final before = onNotification.metrics.extentBefore;
                final max = onNotification.metrics.maxScrollExtent;
                if (before == max) {
                  if(connect){
                    ref.read(movieProvider(apiPath).notifier).loadMore();
                  }
                }
                return true;
              },
              child: GridView.builder(
                key: PageStorageKey(pageKey),
                itemCount: movieData.movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  final movie = movieData.movies[index];
                  return InkWell(
                    splashColor: Colors.red,
                    onTap: () {
                      if(connect){
                        Get.to(() => DetailPage(movie));
                      } else {
                        Fluttertoast.showToast(
                            msg: "Check your internet connection",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    },
                    child: CachedNetworkImage(
                        imageUrl: movie.poster_path,
                        placeholder: (context, url) => spin,
                        errorWidget: (context, url, error) {
                          return Image.asset('images/movie.png');
                        },
                    ),

                  );
                },
              ),
            );
          }
        }
        );
  }
}

