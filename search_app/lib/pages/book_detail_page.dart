import 'package:flutter/material.dart';
import 'package:search_app/model/Book.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({
    this.book,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(book.title),
    ),
    body: ListView(
      children: [
        Image.network(
          book.urlImage,
          height: 300,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        Text(
          book.title,
          style: TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}