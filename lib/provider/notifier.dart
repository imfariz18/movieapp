// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart'as http;
// class PostProvider extends ChangeNotifier{
//   List<Movie> movies=[];

//   List<Movie> get allPosts => movies;

//   Future<void> getData() async {
//   final response =
//       await http.get(Uri.parse("http:omdbapi.com/?s=tt3896198&apikey=772729c5"));
//   print(response.body);
//   List<dynamic> decodedPost = jsonDecode(response.body);
//   Iterable<Movie> finalPosts = decodedPost
//       .map((postMap) => Movie.fromMap(postMap));
//   movies=finalPosts.toList();
//   notifyListeners();
  
// }

// }

// class Movie {
//   String title;

//   Movie({required this.title});

//   factory Movie.fromMap(Map<String, dynamic> postMap) {
//     return Movie(title: postMap["title"] ?? "");
//   }
// }