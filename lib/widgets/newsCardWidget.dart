import 'package:flutter/material.dart';
import 'package:newsApp/models/news.dart';
import 'package:newsApp/pages/newsDetailsPage.dart';

class NewsWidget extends StatelessWidget {
  final News news;

  const NewsWidget({Key key, this.news}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.blockSizeVertical * 4,
          vertical: context.blockSizeVertical * 4),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsDetail(
                        news: news,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          // height: 250,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: context.blockSizeHorizontal * 4),
                child: Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(-context.blockSizeHorizontal * 6, 0),
                      child: ClipOval(
                        child: Hero(
                          tag: news.title,
                          child: Container(
                              height: context.blockSizeVertical * 7,
                              width: context.blockSizeVertical * 7,
                              child: news.urlToImage == null
                                  ? Image.asset(
                                      "assets/image/imagePlaceHold.png",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      news.urlToImage,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: context.blockSizeHorizontal * 10,
                            right: context.blockSizeHorizontal * 4,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${news.title ?? ""}",
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "${news.author ?? " "}",
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              news.publishedAt == null
                                  ? Text("")
                                  : Text(
                                      "${news.publishedAt.split("T")[0] ?? ""}",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.grey),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: news.content == null
                              ? Text("")
                              : Text(
                                  "\t \t ${news.content.split("[+")[0]}",
                                  maxLines: 5,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                ),
                        ),
                        SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                              height: 163,
                              width: MediaQuery.of(context).size.width * 3 / 2,
                              color: Colors.white,
                              child: news.urlToImage == null
                                  ? Image.asset(
                                      "assets/image/imagePlaceHold.png",
                                      fit: BoxFit.fitHeight,
                                    )
                                  : Image.network(
                                      news.urlToImage,
                                      fit: BoxFit.fill,
                                    )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget backGround() => Stack(
        children: [
          Image.asset(
            "assets/image/bg.png",
          )
        ],
      );
}

extension SizeConfig on BuildContext {
  double get blockSizeHorizontal {
    final _mediaQueryData = MediaQuery.of(this);
    return (_mediaQueryData.size.width / 100);
  }

  double get blockSizeVertical {
    final _mediaQueryData = MediaQuery.of(this);
    return (_mediaQueryData.size.height / 100);
  }
}
