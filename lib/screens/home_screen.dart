import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/services/movie_api.dart';
import 'package:movie/widgets/movie_item.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiProvider apiProvider = ApiProvider();
  Future<Movies> movies;
  String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    movies = apiProvider.getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: movies,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print("Has Data: ${snapshot.hasData}");
            return ListView.builder(
              itemCount: snapshot.data.results.length,
              itemBuilder: (BuildContext context, int index) {
                return MovieItem(
                  poster:
                  '$imageBaseUrl${snapshot.data.results[index].posterPath}',
                  title: '${snapshot.data.results[index].title}',
                  overview: '${snapshot.data.results[index].overview}',
                  date: '${snapshot.data.results[index].releaseDate}',
                );
              },
            );
          } else if (snapshot.hasError) {
            print("Has Error: ${snapshot.hasError}");
            return Text('Error!!!');
          } else {
            print("Loading...");
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

