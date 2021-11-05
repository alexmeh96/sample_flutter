import 'dart:async';

import 'package:flutter/material.dart';
import 'package:search_app/api/book_api.dart';
import 'package:search_app/widget/search_widget.dart';

import '../model/Book.dart';

class SearchNetworkPage extends StatefulWidget {
  const SearchNetworkPage({Key key}) : super(key: key);

  @override
  _SearchNetworkPageState createState() => _SearchNetworkPageState();
}

class _SearchNetworkPageState extends State<SearchNetworkPage> {
  List<Book> books = [];
  String query = '';
  Timer debouncer;

  @override
  void dispose() {
    if (debouncer != null)
      debouncer.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search network"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SearchWidget(
            text: query,
            hintText: "Title or Author name",
            onChanged: searchBook,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];

                return ListTile(
                  leading: Image.network(
                    book.urlImage,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(book.title),
                  subtitle: Text(book.author),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void searchBook(String query) async => debounce(() async {
        List<Book> books = [];
        if (query != "") {
          books = await BooksApi.getBooks(query);
        }

        setState(() {
          this.query = query;
          this.books = books;
        });
      });
}
