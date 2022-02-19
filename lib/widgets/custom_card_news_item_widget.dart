import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_test_app/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/home_screen.dart';

class CustomCard extends StatelessWidget {
  List<Articles> articlList;
  int i;
  Function setStateCall;
  CustomCard(
      {Key? key,
      required this.articlList,
      required this.i,
      required this.setStateCall})
      : super(key: key);

  ValueNotifier<bool> isFavorite = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Container(
          height: h * .6,
          width: w,
          child: Column(children: [
            Stack(
              children: [
                Container(
                  width: w,
                  height: h * .25,
                  child: CachedNetworkImage(imageUrl: articlList[i].urlToImage != null
                        ? articlList[i].urlToImage!
                        : "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",
                        fit: BoxFit.cover,),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: ValueListenableBuilder(
                      valueListenable: isFavorite,
                      builder: (context, v, c) {
                        return InkWell(
                          onTap: () {
                            if (articlList[i].isAddFavorite == false) {
                              isFavorite.value = true;
                              articlList[i].isAddFavorite = true;
                              favoriteLists.add(articlList[i]);
                              setStateCall();
                            } else if (articlList[i].isAddFavorite == true) {
                              isFavorite.value = false;
                              articlList[i].isAddFavorite = false;
                              favoriteLists.remove(articlList[i]);
                              setStateCall();
                            }
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            child: Center(
                                child: Icon(
                              isFavorite.value == true ||
                                      articlList[i].isAddFavorite == true
                                  ? CupertinoIcons.heart_solid
                                  : CupertinoIcons.heart,
                              color: Colors.red,
                            )),
                          ),
                        );
                      }),
                ),
                if(articlList[i].source!.name!=null)
                Positioned(
                top: 15,
                left: 10,
                child: Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.black45,
                ),
              
                padding:const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                constraints: BoxConstraints(maxHeight: 25,maxWidth: w*.8,minHeight: 25,minWidth: w*.2),
                child: Text(articlList[i].source!.name!=null?articlList[i].source!.name!:"",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
                ),
                ))
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            maxHeight: 75,
                            minHeight: 50,
                            maxWidth: w,
                            minWidth: w),
                          
                        child: Text(
                          articlList[i].title != null ? articlList[i].title! : "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 16,
                            
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        constraints: BoxConstraints(
                            maxHeight: 75,
                            minHeight: 40,
                            maxWidth: w,
                            minWidth: w),
                          
                        child: Text(articlList[i].description != null
                            ? articlList[i].description!
                            : "",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,),),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                         constraints: BoxConstraints(
                            maxHeight: 50,
                            minHeight: 40,
                            maxWidth: w,
                            minWidth: w),
                        child: Text(articlList[i].content != null
                            ? articlList[i].content!
                            : "",maxLines: 3,overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 13,)
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("For more details visit: ",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color:Colors.black),),
                      const SizedBox(height: 5,),
                       InkWell(
                       onTap: ()async{
                      if (!await launch(articlList[i].url!)) throw 'Could not launch ';},
                       borderRadius: BorderRadius.circular(5),
                         child: Container(
                         padding: const EdgeInsets.all(5),
                         constraints: BoxConstraints(
                         maxHeight: 60,maxWidth: w,minHeight: 20,minWidth: w),
                         decoration: BoxDecoration(
                                         
                         borderRadius: BorderRadius.circular(5),
                         color: Colors.grey[100],
                         ),
                                   
                         child:  Text(articlList[i].url!,style:const TextStyle(fontSize: 10,fontWeight: FontWeight.w600,color:Colors.blue),)),
                       ),
                       const SizedBox(height: 5,),
                       const Spacer(),
                       SizedBox(
                         height: 20,
                         width: w,
                         child: Row(
                           children: [
                             
                               const Text("Published at :",style: TextStyle(fontSize: 12,color: Colors.black87,fontWeight: FontWeight.w600),),
                               const SizedBox(width: 5,),
                               const Icon(CupertinoIcons.clock,size: 18,color: Colors.brown,),
                             const SizedBox(width: 10,),
                             Text(articlList[i].publishedAt!,style:const TextStyle(fontSize: 12,color: Colors.black87,fontWeight: FontWeight.w600),),
                           ],
                         ),
                       )
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
