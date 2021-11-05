import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:search_app/model/Book.dart';

import '../api/book_api.dart';

class FormTypeAheadPage extends StatefulWidget {
  const FormTypeAheadPage({Key key}) : super(key: key);

  @override
  _FormTypeAheadPageState createState() => _FormTypeAheadPageState();
}

class _FormTypeAheadPageState extends State<FormTypeAheadPage> {
  final formKey = GlobalKey<FormState>();
  final controllerCity = TextEditingController();
  final controllerFood = TextEditingController();

  String selectedBook;
  String selectedAuthor;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildBook(),
                    SizedBox(height: 16),
                    buildAuthor(),
                    SizedBox(height: 12),
                    buildSubmit(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildBook() => TypeAheadFormField<Book>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: controllerCity,
          decoration: InputDecoration(
            labelText: 'Book',
            border: OutlineInputBorder(),
          ),
        ),
        suggestionsCallback: (text) async {
          return await BooksApi.getBooks(text);
        },
        itemBuilder: (context, Book suggestion) => ListTile(
          title: Text(suggestion.title),
        ),
        onSuggestionSelected: (Book suggestion) {
          controllerCity.text = suggestion.title;
        },
        validator: (value) =>
            value != null && value.isEmpty ? 'Please select a city' : null,
        onSaved: (value) => selectedBook = value,
      );

  Widget buildAuthor() => TypeAheadFormField<Book>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: controllerFood,
          decoration: InputDecoration(
            labelText: 'Author',
            border: OutlineInputBorder(),
          ),
        ),
        suggestionsCallback: (text) async {
          return await BooksApi.getBooks(text);
        },
        itemBuilder: (context, Book suggestion) => ListTile(
          title: Text(suggestion.author),
        ),
        onSuggestionSelected: (Book suggestion) =>
            controllerFood.text = suggestion.author,
        validator: (value) =>
            value != null && value.isEmpty ? 'Please select a food' : null,
        onSaved: (value) => selectedAuthor = value,
      );

  Widget buildSubmit(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        child: Text('Submit', style: TextStyle(fontSize: 20)),
        onPressed: () {
          final form = formKey.currentState;

          if (form.validate()) {
            form.save();
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(
                    'Your Favourite Book is $selectedBook\nYour Favourite Author is $selectedAuthor'),
              ));
          }
        },
      );
}
