import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie API App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final Map<String, dynamic> movieData = {
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

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: ListView(
        children: <Widget>[
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
          ListTile(
            title: Text(movieData['following_production']['title']),
            subtitle: Text(movieData['following_production']['type']),
          ),
          Image.network(movieData['following_production']['poster_url']),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(movieData['following_production']['overview']),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Release Date: ${movieData['following_production']['release_date']}'),
          ),
        ],
      ),
    );
  }
}
