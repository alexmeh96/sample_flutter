import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:search_app/model/meal.dart';


class MealApi {

  static Future<List<Meal>> getMealList(int offset, int limit, {String searchTerm}) async {
    if (searchTerm == null) return [];
    try {
      final uri = Uri.http(
        // '54.93.178.120',
        '192.168.0.107:8080',
        '/api/v1/restaurant/search-regx-meals',
        <String, String>{'page': '$offset', 'size': '$limit', 'text': '$searchTerm'},
      );

      final response = await http.Client().get(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

      if (response.statusCode == 200) {
        // print(utf8.decode(response.bodyBytes));


        final body =
        json.decode(utf8.decode(response.bodyBytes)) as List;
        // final body = json.decode(response.body)["restaurants"] as List;

        print(body);

        final List<Meal> meals = body.map((e) => Meal.fromJson(e)).toList();

        return meals;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      throw Exception(e);

    }
    throw Exception('error fetching restaurants');

  }

//
//   static Future<List<Meal>> getMealList(
//     int offset,
//     int limit, {
//     String searchTerm,
//   }) async =>
//       http
//           .get(
//             _ApiUrlBuilder.mealList(offset, limit, searchTerm: searchTerm),
//           )
//           .mapFromResponse<List<Meal>, List<dynamic>>(
//             (jsonArray) => _parseItemListFromJsonArray(
//               jsonArray,
//               (jsonObject) => Meal.fromJson(jsonObject),
//             ),
//           );
//
//   static List<T> _parseItemListFromJsonArray<T>(
//     List<dynamic> jsonArray,
//     T Function(dynamic object) mapper,
//   ) =>
//       jsonArray.map(mapper).toList();
// }
//
// class GenericHttpException implements Exception {}
//
// class NoConnectionException implements Exception {}
//
// class _ApiUrlBuilder {
//   static const _baseUrl = 'http://54.93.178.120/api/v1/restaurant/';
//   static const _mealResource = 'search-regx-meals/';
//
//   static Uri mealList(
//     int offset,
//     int limit, {
//     String searchTerm,
//   }) =>
//       Uri.parse(
//         '$_baseUrl$_mealResource?'
//         'page=$offset'
//         '&size=$limit'
//         '${_buildSearchTermQuery(searchTerm)}',
//       );
//
//   static String _buildSearchTermQuery(String searchTerm) =>
//       searchTerm != null && searchTerm.isNotEmpty
//           ? '&text=${searchTerm.replaceAll(' ', '+').toLowerCase()}'
//           : '';
// }
//
// extension on Future<http.Response> {
//   Future<R> mapFromResponse<R, T>(R Function(T) jsonParser) async {
//     try {
//       final response = await this;
//       if (response.statusCode == 200) {
//         return jsonParser(jsonDecode(response.body));
//       } else {
//         throw GenericHttpException();
//       }
//     } on SocketException {
//       throw NoConnectionException();
//     }
//   }
}
