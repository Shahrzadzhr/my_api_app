import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movie API App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<Map<String, dynamic>> fetchMovieData() async {
    await Future.delayed(const Duration(seconds: 2));
    return {
      "days_until": 37,
      "following_production": {
        "days_until": 93,
        "id": 138501,
        "overview":
            "Follow Agatha Harkness before and after her appearance in WandaVision.",
        "poster_url":
            "https://image.tmdb.org/t/p/w500/2a6bSlg7U5ldtelPssyay4Vbl6U.jpg",
        "release_date": "2024-09-18",
        "title": "Agatha All Along",
        "type": "TV Show"
      },
      "id": 533535,
      "overview":
          "A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him. But when his homeworld faces an existential threat, Wade must reluctantly suit-up again with an even more reluctant Wolverine.",
      "poster_url":
          "https://image.tmdb.org/t/p/w500/jbwYaoYWZwxtPP76AZnfYKQjCEB.jpg",
      "release_date": "2024-07-24",
      "title": "Deadpool & Wolverine",
      "type": "Movie"
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchMovieData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var movieData = snapshot.data!;
            return ListView(
              children: [
                MovieDetailsTile(movieData: movieData),
                MovieDetailsTile(movieData: movieData['following_production']),
              ],
            );
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}

class MovieDetailsTile extends StatelessWidget {
  final Map<String, dynamic> movieData;

  const MovieDetailsTile({required this.movieData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(movieData['title']),
          subtitle: Text(movieData['type']),
        ),
        Image.network(movieData['poster_url']),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(movieData['overview']),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Release Date: ${movieData['release_date']}'),
        ),
        const Divider(),
      ],
    );
  }
}
