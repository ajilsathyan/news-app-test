import 'package:animation_wrappers/animations/fade_animation.dart';
import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_test_app/models/news_model.dart';
import 'package:news_test_app/repositories/news_model_repository.dart';
import 'package:news_test_app/widgets/custom_card_news_item_widget.dart';

import '../models/categroy_model.dart';
import '../widgets/bottom_nav_item_widget.dart';

List<Articles> favoriteLists = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tab;

  NewsRepository repository = NewsRepository();
  List<Articles> articlList = [];

  ScrollController scrollController = ScrollController();
  Future<List<Articles>>? getData;

  int page = 1;
  bool isLoading = false;
  @override
  void initState() {
    repository.getNewsData(page, 5).then((value) {
      if (value.length != 0) {
        setState(() {
          articlList.addAll(value);
          isLoading = true;
        });
        page++;
        print(page);
      } else {
        setState(() {
          isLoading = true;
        });
      }
    });
    tab = TabController(vsync: this, length: 3);

    tab.addListener(() {
      setState(() {});
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print(scrollController.position.pixels);
        repository.getNewsData(page, 5).then((value) {
          if (value.length != 0) {
            setState(() {
              articlList.addAll(value);
            });

            page++;
            print(page);
          }
        });
      }
    });
    super.initState();
  }

  callSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        width: w,
        height: h,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: tab,
                children: [
                  /// Home
                  Container(
                    child: isLoading
                        ? articlList.isNotEmpty
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  setState(() {
                                    isLoading = false;
                                    articlList.clear();
                                    page=1;
                                  });
                                  repository.getNewsData(page, 5).then((value) {
                                    if (value.length != 0) {
                                      setState(() {
                                        articlList.addAll(value);
                                        isLoading = true;
                                      });
                                      page++;
                                      print(page);
                                    } else {
                                      setState(() {
                                        isLoading = true;
                                      });
                                    }
                                  });
                                },
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    controller: scrollController,
                                    itemCount: articlList.length + 1,
                                    itemBuilder: (context, i) {
                                      if (i == articlList.length) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50,
                                          child:const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      }
                                      return FadedScaleAnimation(
                                        child: CustomCard(
                                            articlList: articlList,
                                            i: i,
                                            setStateCall: callSetState),
                                      );
                                    }),
                              )
                            : const Center(
                                child: Text(
                                    "News list is empty please reload again"),
                              )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),

                  /// Catefories
                  Container(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,crossAxisSpacing: 0,mainAxisSpacing:0),
                        itemCount: categoryList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, i) {
                          return FadedScaleAnimation(
                            child: Card(
                              child:Container(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 200,
                                      child: CachedNetworkImage(imageUrl: categoryList[i].url,
                                      fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.black54,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Center(child: Text(categoryList[i].title,style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w600),),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(width: 30,height: 30,
                                          
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: Colors.white
                                          ),
                                          child: Icon(Icons.arrow_forward,color: Colors.blue,size: 16,),)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),

                  /// Favorites
                  Container(
                    child: favoriteLists.isNotEmpty
                        ? ListView.builder(
                            itemCount: favoriteLists.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, i) {
                              return FadedScaleAnimation(
                                child: CustomCard(
                                  articlList: favoriteLists,
                                  i: i,
                                  setStateCall: callSetState,
                                ),
                              );
                            })
                        : const Center(
                            child: Text("No favorites added yet"),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        width: w,
        child:
            TabBar(controller: tab, indicatorColor: Colors.transparent, tabs: [
          BottomNavItemWidget(
            color: tab.index == 0 ? Colors.blue : Colors.grey,
            icon: tab.index == 0 ? Icons.home : Icons.home_outlined,
            title: "Home",
          ),
          BottomNavItemWidget(
            color: tab.index == 1 ? Colors.blue : Colors.grey,
            icon: tab.index == 1 ? Icons.category : Icons.category_outlined,
            title: "Categories",
          ),
          BottomNavItemWidget(
            color: tab.index == 2 ? Colors.blue : Colors.grey,
            icon: tab.index == 2
                ? CupertinoIcons.heart_solid
                : CupertinoIcons.heart,
            title: "Favorites",
          ),
        ]),
      ),
    );
  }
}
