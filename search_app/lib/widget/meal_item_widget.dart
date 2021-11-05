import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:search_app/model/meal.dart';
import 'package:search_app/pages/character_detail_page.dart';
import 'package:search_app/pages/meal_detail_page.dart';

import '../model/character.dart';

class MealItemWidget extends StatelessWidget {
  const MealItemWidget({
    this.meal,
    Key key,
  }) : super(key: key);

  final Meal meal;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MealDetailPage(meal: meal),
          ));
        },
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: CachedNetworkImageProvider(meal.img),
        ),
        title: Text(meal.name),
      );
}
