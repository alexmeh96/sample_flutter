import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SearchSliverWidget extends StatefulWidget {
  const SearchSliverWidget({
    Key key,
    this.onChanged,
    this.debounceTime,
    // this.text,
    this.hintText,
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final Duration debounceTime;
  // final String text;
  final String hintText;

  @override
  _SearchSliverWidgetState createState() => _SearchSliverWidgetState();
}

class _SearchSliverWidgetState extends State<SearchSliverWidget> {
  final StreamController<String> _textChangeStreamController =
      StreamController();
  StreamSubscription _textChangesSubscription;

  final controller = TextEditingController();

  String text = "";

  @override
  void initState() {
    _textChangesSubscription = _textChangeStreamController.stream
        .debounceTime(
          widget.debounceTime ?? const Duration(milliseconds: 500),
        )
        .distinct()
        .listen((text) {
      this.text = text;
      final onChanged = widget.onChanged;
      if (onChanged != null) {
        onChanged(text);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        autofocus: true,
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: text.isNotEmpty
              ? GestureDetector(
            child: Icon(Icons.close, color: style.color),
            onTap: () {
              controller.clear();
              widget.onChanged('');
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {
                this.text = "";
              });
            },
          )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: (text) {
          setState(() {
            this.text = text;
          });
          _textChangeStreamController.add(text);
        }
      ),
    );
  }

  @override
  void dispose() {
    _textChangeStreamController.close();
    _textChangesSubscription.cancel();
    controller.dispose();
    super.dispose();
  }
}

