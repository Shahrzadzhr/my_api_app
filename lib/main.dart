import 'package:flutter/material.dart';

import 'api_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'API App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Data'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _apiService.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.network(snapshot.data?['poster_url']),
                  Text(snapshot.data?['title'],
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text(snapshot.data?['overview']),
                  Text('Release Date: ${snapshot.data?['release_date']}'),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
