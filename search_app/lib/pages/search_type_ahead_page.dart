import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:search_app/model/Book.dart';
import 'package:search_app/api/book_api.dart';
import 'package:search_app/pages/book_detail_page.dart';

class SearchTypeAheadPage extends StatefulWidget {
  SearchTypeAheadPage({Key key}) : super(key: key);

  final SuggestionsBoxController suggestionsBoxController =
      SuggestionsBoxController();

  final TextEditingController textEditingController = TextEditingController();

  @override
  _SearchTypeAheadPageState createState() => _SearchTypeAheadPageState();
}

class _SearchTypeAheadPageState extends State<SearchTypeAheadPage> {
  bool isHide;

  @override
  void initState() {
    isHide = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScope.of(context).unfocus();
        // new TextEditingController().clear();
        widget.suggestionsBoxController.close();
        setState(() {
          isHide = true;
        });
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: 42,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              border: Border.all(color: Colors.black26),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TypeAheadField<Book>(
              suggestionsBoxController: widget.suggestionsBoxController,
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                constraints: BoxConstraints(maxHeight: 300),
                borderRadius: BorderRadius.circular(12),
              ),
              autoFlipDirection: true,
              debounceDuration: Duration(milliseconds: 300),
              hideSuggestionsOnKeyboardHide: false,
              keepSuggestionsOnLoading: false,
              hideOnError: true,
              hideOnEmpty: true,
              hideOnLoading: isHide,
              loadingBuilder: (context) {
                return Container(
                    height: 80,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              },
              textFieldConfiguration: TextFieldConfiguration(
                controller: widget.textEditingController,
                onTap: () {
                  // print("tap: $isHide");

                  setState(() {
                    isHide = false;
                  });
                },
                // onChanged: (query) {
                //   print("onChanged: $isHide");
                // },
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.black),
                  hintText: "search",
                  border: InputBorder.none,
                ),
              ),
              suggestionsCallback: (pattern) async {
                print("getBooks1");
                if (pattern == "") return null;
                return await BooksApi.getBooks(pattern);
              },
              itemBuilder: (context, Book suggestion) {
                final book = suggestion;

                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      child: Image.network(
                        book.urlImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(book.title),
                  ),
                );
              },
              onSuggestionSelected: (Book suggestion) {
                final book = suggestion;

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BookDetailPage(book: book),
                ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
