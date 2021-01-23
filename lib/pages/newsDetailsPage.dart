import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsApp/models/news.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatefulWidget {
  final News news;

  const NewsDetail({Key key, this.news}) : super(key: key);
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  bool pageLoaded = false;
  bool failed = false;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Hero(tag: widget.news.title, child: Text(widget.news.title)),
        ),
        body: Stack(
          children: [
            failed
                ? Container()
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            Opacity(
              opacity: pageLoaded ? 1.0 : 0.3,
              child: WebView(
                initialUrl: widget.news.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebResourceError: (error) {
                  setState(() {
                    failed = true;
                    Fluttertoast.showToast(
                        msg: "Something went wrong..! Try again later",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Future.delayed(const Duration(seconds: 3), () {
                      Navigator.pop(context);
                    });
                  });
                },
                onPageFinished: (value) {
                  setState(() {
                    pageLoaded = true;
                  });
                },
              ),
            ),
          ],
        ),
      );
}
