import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_demo/models/drink_response.dart';
import 'package:new_demo/models/user_response.dart';
import 'package:new_demo/screens/data_page.dart';
import 'package:new_demo/services/preference.dart';

class DataRepository {
  Future<DrinkResponse> getDrink() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=mar'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

      var jsonResponse = json.decode(responseString);
      var data = DrinkResponse.fromJson(jsonResponse);
      Preference.setString('drink', data.toJson().toString());
      return data;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<UserResponse> getData() async {
    var request = http.Request('GET', Uri.parse('https://randomuser.me/api/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseString);
      var data = UserResponse.fromJson(jsonResponse);
      Preference.setString('user', data.toJson().toString());
      return data;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
