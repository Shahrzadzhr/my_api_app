import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    var url = Uri.parse(
        'https://image.tmdb.org/t/p/w500/2a6bSlg7U5ldtelPssyay4Vbl6U.jpg');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load movie data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load movie data: $e');
    }
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
