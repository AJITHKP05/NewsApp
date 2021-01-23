import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:newsApp/models/news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    yield NewsInitial();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // I am not connected to any network.
      Fluttertoast.showToast(
          msg:
              "Please turn ON mobile connectivity or connect to a network to continue",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      yield Error();
    } else {
      if (event is NewsEventLoad) {
        Dio client = Dio();
        String url = filterUrl(event.filter);
        final response = await client.get(url);
        List<News> list = [];

        if (response.statusCode == 200) {
          (response.data['articles'] as List).forEach((element) {
            list.add(News.fromMap(element));
          });
          yield NewsLoaded(list);
        } else
          yield Error();
      }
    }
  }

  String filterUrl(String filter) {
    switch (filter) {
      case "Wall Street Journal":
        return "http://newsapi.org/v2/everything?domains=wsj.com&apiKey=3aed9d2d15d64bf18fbcf65c8899e6be";
        break;
      case "TechCrunch":
        return "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=3aed9d2d15d64bf18fbcf65c8899e6be";
        break;
      case "Apple":
        return "http://newsapi.org/v2/everything?q=apple&from=2021-01-22&to=2021-01-22&sortBy=popularity&apiKey=3aed9d2d15d64bf18fbcf65c8899e6be";
        break;
      case "business":
        return "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3aed9d2d15d64bf18fbcf65c8899e6be";
        break;
      case "Bitcoin":
        return "http://newsapi.org/v2/everything?q=bitcoin&from=2020-12-23&sortBy=publishedAt&apiKey=3aed9d2d15d64bf18fbcf65c8899e6be";
        break;
      default:
        return "http://newsapi.org/v2/everything?domains=wsj.com&apiKey=3aed9d2d15d64bf18fbcf65c8899e6be";
    }
  }
}
