class Country {
  String name;
  String capital;
  String region;
  String flagUrl;


  Country(this.name, this.capital,this.region, this.flagUrl);

  Country.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.capital = json['capital'];
    this.region = json['Asia'];
    this.flagUrl = json['flag'];
  }
}

class Answer extends Country {

List<String> choices;
String answer;
  String result = "";

  Answer({String name, String capital, String region, String flagUrl,this.choices,this.result,this.answer}) : super(name, capital, region, flagUrl);

}
