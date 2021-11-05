import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:search_app/pages/character_detail_page.dart';

import '../model/character.dart';

class CharacterItemWidget extends StatelessWidget {
  const CharacterItemWidget({
    this.character,
    Key key,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CharacterDetailPage(character: character),
          ));
        },
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: CachedNetworkImageProvider(character.pictureUrl),
        ),
        title: Text(character.name),
      );
}
