import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<Map<String, dynamic>> fetchMovieData() async {
    final response =
        await http.get(Uri.parse('https://www.whenisthenextmcufilm.com/api'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load movie data');
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
            return MovieDetails(snapshot.data!);
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}

class MovieDetails extends StatelessWidget {
  final Map<String, dynamic> movieData;

  const MovieDetails(this.movieData, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(movieData['title'],
            style: Theme.of(context).textTheme.headlineSmall),
        Image.network(movieData['poster_url']),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(movieData['overview']),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Release Date: ${movieData['release_date']}'),
        ),
      ],
    );
  }
}
