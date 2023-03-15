import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'models.dart';
import 'package:breaking_bad/quotes_screen.dart';
import 'dart:core';
import 'dart:convert';

class HomesScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  
  Future<List<Character>> fetchBbCharacters() async =>
    http.get(Uri.parse('https://rickandmortyapi.com/api/character'))
      .then((res) {
        List characters = jsonDecode(res.body);
        return characters.map((char) => Character.fromJson(char)).toList();
      })
      .catchError((err) => throw Exception('Failed to load characters from API'));

  @override
  widget build(BuildContext context) => Scaffold{
    appBar: AppBar(
      title: const Text('Rick and Morty Quotes')
    ),
    body: FutureBuilder(
      future: fetchBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: const SilverGridDelegateWithFixedrossAxisCount(
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 5/3,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) => GridTile(
              footer: Container(
                margin: const EdgeInsets.only(bottom: 25.0, left: 25.0),
                child: Text(
                  '${snapshot.data?[index].name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
          ),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  // print('id ${snapshot.data![index].id}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuotesScreen(id: snapshot.data![index].id)),
                  );
                },
                child: Image.network(
                  '${snapshot.data?[index].imgUrl}',
                  fit: BoxFit.fitWidth,
                ),
              )
            ),
            itemCount: snapshot.data!.length,
          );
        }
        else if (snapshot.hasError) {
          return Center(
              child: Container(
              width: 250,
              height: 150,
              alignment: const Alignment(0, 0),
              color: Colors.red,
              child: const Text(
                'Error',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            )
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    ),
  );
}
