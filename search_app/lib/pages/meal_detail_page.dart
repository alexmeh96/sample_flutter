import 'package:flutter/material.dart';
import 'package:search_app/model/Book.dart';
import 'package:search_app/model/character.dart';
import 'package:search_app/model/meal.dart';

class MealDetailPage extends StatelessWidget {
  final Meal meal;

  const MealDetailPage({
    this.meal,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(meal.name),
    ),
    body: ListView(
      children: [
        Image.network(
          meal.img,
          height: 300,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        Text(
          meal.name,
          style: TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}