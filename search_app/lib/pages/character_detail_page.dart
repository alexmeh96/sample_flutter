import 'package:flutter/material.dart';
import 'package:search_app/model/Book.dart';
import 'package:search_app/model/character.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({
    this.character,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(character.name),
    ),
    body: ListView(
      children: [
        Image.network(
          character.pictureUrl,
          height: 300,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        Text(
          character.name,
          style: TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}