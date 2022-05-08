import 'dart:convert';
import 'package:new_demo/models/medicine_response.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  Future<MedicineResponse> getMedicine() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://run.mocky.io/v3/5c71eb3b-3ef1-4457-8357-756ac1147762'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseString);
      return MedicineResponse.fromMap(jsonResponse);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
