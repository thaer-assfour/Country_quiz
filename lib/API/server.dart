import 'dart:convert';
import 'package:flag_quiz/country/country.dart';
import 'package:http/http.dart' as http;

class FlagServer {
  Future getData() async {
    String url = "https://restcountries.eu/rest/v2/all";
    var response = await http.get(url);

    var body = json.decode(response.body) as List;
    List<Country> countryList =
        body.map((json) => Country.fromJson(json)).toList();

    return countryList;
  }
}
