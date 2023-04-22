import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:newmovieapp/screens/search_page.dart';
import '../common_widgets/tab_bar_widget.dart';
import '../constants/enum.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xfff283035),
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          toolbarHeight: 70,
          elevation: 0,
          title: const Text(
            'Watch Now',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(()=> SearchPage());
              },
              icon: const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            indicatorColor: Colors.red,
            tabs: [
              Tab(text: CategoryType.Now_Playing.name),
              Tab(text: CategoryType.Popular.name),
              Tab(text: CategoryType.Top_Rated.name),
              Tab(text: CategoryType.Upcoming.name),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(5.0),
          child: TabBarView(
            children: [
              TabBarWidget(
                  categoryType: CategoryType.Now_Playing,
                  pageKey: 'NowPlaying'),
              TabBarWidget(
                categoryType: CategoryType.Popular,
                pageKey: 'Popular',
              ),
              TabBarWidget(
                categoryType: CategoryType.Top_Rated,
                pageKey: 'TopRated',
              ),
              TabBarWidget(
                categoryType: CategoryType.Upcoming,
                pageKey: 'Upcoming',
              )
            ],
          ),
        ),
      ),
    );
  }
}
