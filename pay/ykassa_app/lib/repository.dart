import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';


void fetchPai(String token, double cost) async {
  try {

    final bodyMap = {
      "payment_token": token,
      "amount": {
        "value": cost.toString(),
        "currency": "RUB",
      },
      "confirmation": {
        "type": "redirect",
        "enforce": false,
        "return_url": "https://www.merchant-website.com/return_url"
      },
      "capture": true,
      "description": "Пожертвования"
    };

    final uri = Uri.https(
      'api.yookassa.ru',
      'v3/payments',
    );

    final auth = base64Encode(utf8.encode('shop_id:secret_key'));

    final response = await http.Client().post(
      uri,
      headers: <String, String>{
        'Idempotence-Key': Uuid().v4(),
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Basic $auth',
      },
      body: jsonEncode(bodyMap),
    );

    if (response.statusCode == 200) {

      final body = json.decode(utf8.decode(response.bodyBytes));

      print(body);

      if (body["status"] == "waiting_for_capture" || body["status"] == "succeeded") return;

    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e);
    throw Exception(e);
  }
  throw Exception('error fetching updateDiet');
}