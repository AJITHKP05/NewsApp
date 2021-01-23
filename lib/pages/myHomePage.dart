import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsApp/blocs/bloc/news_bloc.dart';
import 'package:newsApp/widgets/newsCardWidget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("News App"),
            bottom: TabBar(
              indicatorColor: Colors.orange,
              isScrollable: true,
              tabs: [
                Tab(
                  text: "Wall Street Journal",
                ),
                Tab(
                  text: "TechCrunch",
                ),
                Tab(
                  text: "Apple",
                ),
                Tab(
                  text: "business",
                ),
                Tab(
                  text: "Bitcoin",
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            Home(
              filter: "Wall Street Journal",
            ),
            Home(filter: "TechCrunch"),
            Home(filter: "Apple"),
            Home(filter: "business"),
            Home(filter: "Bitcoin"),
          ])),
    );
  }
}

class Home extends StatefulWidget {
  final String filter;

  const Home({Key key, this.filter}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewsBloc()..add(NewsEventLoad(widget.filter)),
        child: BlocBuilder<NewsBloc, NewsState>(builder: (ctx, state) {
          if (state is NewsInitial) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is Error) return dataWidget(ctx, "No internet Connection");
          if (state is NewsLoaded) {
            return RefreshIndicator(
                onRefresh: () async {
                  ctx.read<NewsBloc>()..add(NewsEventLoad(widget.filter));
                },
                child: state.list.isEmpty
                    ? dataWidget(ctx, null)
                    : Container(
                        child: ListView.builder(
                        itemCount: state.list.length,
                        itemBuilder: (context, index) => NewsWidget(
                          news: state.list[index],
                        ),
                      )));
          }

          return Container();
        }));
  }

  dataWidget(BuildContext ctx, String data) => Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(data ?? "No data found.. \n Try sometimes after"),
            RaisedButton(
              onPressed: () {
                ctx.read<NewsBloc>()..add(NewsEventLoad(widget.filter));
              },
              child: Text("Retry"),
            )
          ],
        ),
      ));
}
