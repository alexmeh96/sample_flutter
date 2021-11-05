import 'package:flutter/material.dart';
import 'package:search_app/pages/search_infinity_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: TextField(
            // showCursor: false,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchInfinityPage(),
              ));
            },
            // controller: controller,
            decoration: InputDecoration(
              icon: Icon(Icons.search, color: Colors.black54),
              // suffixIcon: widget.text.isNotEmpty
              //     ? GestureDetector(
              //   child: Icon(Icons.close, color: Colors.black54),
              //   onTap: () {
              //     controller.clear();
              //     widget.onChanged('');
              //     FocusScope.of(context).requestFocus(FocusNode());
              //   },
              // )
              //     : null,
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.black54),
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.black54),
            // onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}
