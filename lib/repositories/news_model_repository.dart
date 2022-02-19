import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/api_key.dart';
import '../models/news_model.dart';
class NewsRepository{

  
  Future<List<Articles>> getNewsData(int page,int pageSize )async{
      String url="https://newsapi.org/v2/top-headlines?country=in&apiKey=$API_KEY&page=$page&pageSize=$pageSize";

      var response=await http.get(Uri.parse(url));
      if(response.statusCode==200){
        print(response.body);
        NewsModel data=NewsModel.fromJson(json.decode(response.body));
        return data.articles!;
      }else{
        return [];
      }
  }

}