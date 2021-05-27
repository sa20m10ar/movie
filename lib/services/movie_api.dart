import 'dart:convert';

import 'package:movie/models/movie_model.dart';
import 'package:http/http.dart'  show Client, Response;

class ApiProvider{
  String apiKey = '3a3ba480f88ccc4d7e9130c99c2baf89';
  String baseUrl = 'https://api.themoviedb.org/3';

  Client client = Client();

  Future<Movies> getMovies() async{

    //  String url = '$baseUrl/movie/popular?api_key=$apiKey';
    //  print(url);
    Response response = await client.get('$baseUrl/discover/movie?api_key=$apiKey&page=1');

    if(response.statusCode == 200){
      return Movies.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
  }
}