import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:newmovieapp/providers/search_provider.dart';
import '../constants/const_widgets.dart';
import 'detail_page.dart';


class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Consumer(
            builder: (context, ref, _) {
              final data = ref.watch(searchProvider);
              return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: searchcontroller,
                        onFieldSubmitted: (val) {
                        ref.read(searchProvider.notifier).getSearch(val.trim());
                        searchcontroller.clear();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search Movie',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10)
                        ),
                      ),
                    ),
                    Expanded(
                      child: data.isLoad ? Center(child: CircularProgressIndicator()) : data.isError ? Center(child: Text(data.errMessage)) : GridView.builder(
                            itemCount: data.movies.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2 / 3,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                            ),
                            itemBuilder: (context, index) {
                              final movie = data.movies[index];
                              return InkWell(
                                splashColor: Colors.red,
                                onTap: () {
                                  Get.to(()=> DetailPage(movie));
                                },
                                child: CachedNetworkImage(
                                    imageUrl:  movie.poster_path,
                                    placeholder: (context, url) => spin),
                              );

                            },
                          ),
                    )
                  ]
              );
            }
          )
      ),
    );
  }
}
