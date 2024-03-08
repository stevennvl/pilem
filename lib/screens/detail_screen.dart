import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  Future<void> _checkIsFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.containsKey('movie_${widget.movie.id}');
    });
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      final String movieJson = jsonEncode(widget.movie.toJson());
      prefs.setString('movie_${widget.movie.id}', movieJson);

      List<String> favoriteMovieIds =
          prefs.getStringList('favoriteMovies') ?? [];
      favoriteMovieIds.add(widget.movie.id.toString());
      prefs.setStringList('favoriteMovies', favoriteMovieIds);
    } else {
      prefs.remove('movie_${widget.movie.id}');
      List<String> favoriteMovieIds =
          prefs.getStringList('favoriteMovies') ?? [];
      favoriteMovieIds.remove(widget.movie.id.toString());
      prefs.setStringList('favoriteMovies', favoriteMovieIds);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIsFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w500${widget.movie.backdropPath}',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: _toggleFavorite,
                      icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border),
                      color: Colors.red,
                    ),
                  ),
                )
              ]),
              const SizedBox(height: 20),
              const Text(
                'Overview:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(widget.movie.overview),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Release Date:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Text(widget.movie.releaseDate),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Rating:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Text(widget.movie.voteAverage.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}