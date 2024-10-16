import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Homepage> {
  List<Movie> movies = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const Icon(Icons.movie),
          backgroundColor:const Color.fromARGB(255, 78, 77, 77),
          title: const Text(
            "A-Movies" ,
            style: TextStyle(
                fontStyle: FontStyle.normal,
                color: Color.fromARGB(255, 254, 255, 255),
                wordSpacing: 2,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          
        ),
        body: Column(children: [
          Padding(
            padding:const EdgeInsets.all(5),
            child: Container(
              margin:
                  const EdgeInsets.only(left: 70, right: 70, top: 5, bottom: 5),
              height: 30,
              color:Color.fromARGB(255, 67, 67, 67),
              padding: const EdgeInsets.only(left: 1),
              child: SearchBar(
                controller: search,
                elevation:const WidgetStatePropertyAll(20),
                leading: IconButton(
                    onPressed: () async {
                      String data = search.text;
                      provider.allmovies(data);
                      search.clear();
                    },
                    icon:const Icon(Icons.search)),
                hintText: "Search Movie",
                hintStyle: const WidgetStatePropertyAll(
                    TextStyle(color: Colors.black)),
                backgroundColor:const WidgetStatePropertyAll(
                     Color.fromARGB(255, 251, 250, 250)),
                onTap: () {},
              ),
            ),
          ),
          Consumer<MovieProvider>(builder: (context, data, _) {
            return Expanded(
              
                child: GridView.builder(
              itemCount: data.allmovie.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.9, crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  
                  margin:const EdgeInsets.all(5),
                  height: 400,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 70, 70, 70),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:const EdgeInsets.only(left: 10),
                        child: Text(data.allmovie[index].title,style: TextStyle(color: Colors.white,)),
                      ),
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: Image.network(data.allmovie[index].poster),
                      ),
                      
                      
                      Text(data.allmovie[index].year,style: TextStyle(color: Colors.white,),),
                      Text(data.allmovie[index].imbdId,style: TextStyle(color: Colors.white,)),
                      Text(data.allmovie[index].type,style: TextStyle(color: Colors.white,)),
                    ],
                  ),
                );
              },
            ));
          })
        ]),
      ),
    );
  }
}

class MovieProvider extends ChangeNotifier {
  List<Movie> movies = [];

  List<Movie> get allmovie => movies;

  Future<void> allmovies(String data) async {

    final response =
        await http.get(Uri.parse("https://www.omdbapi.com/?s=$data&apikey=772729c5"));
    print(response);
    List<dynamic> decodedmovie = jsonDecode(response.body)["Search"];
    List<Movie> finalmovies =
        decodedmovie.map((movieMap) => Movie.fromMap(movieMap as Map<String,dynamic>)).toList();
        print(finalmovies);
    movies = finalmovies;
    notifyListeners();
  }
}

class Movie {
  String title;
  String poster;
  String year;
  String imbdId;
  String type;

  Movie(
      {required this.title,
      required this.imbdId,
      required this.poster,
      required this.type,
      required this.year});

  factory Movie.fromMap(Map<String, dynamic> movieMap) {
    return Movie(
        title: movieMap["Title"] ?? "",
        poster: movieMap["Poster"] ?? "",
        year: movieMap["Year"] ?? "",
        imbdId: movieMap["imdbID"] ?? "",
        type: movieMap["Type"] ?? "");
  }
}
