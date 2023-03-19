import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:asbeza/data/model/item.dart';

class ApiServiceProvider {
  final String apiUrl = 'https://fakestoreapi.com/products';
  // final String apiUrl ='https://api.edamam.com/api/food-database/v2/parser?app_id=d8a5873d&app_key=bfab2c3b0ceb9566def31a714b36f646&ingr=cheese&nutrition-type=cooking'

  Future<List<Item>?> fetchItem() async {
    try {
      var url = Uri.parse(apiUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Item> model = itemFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
