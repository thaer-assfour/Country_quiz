class Country {
  String name;
  String capital;
  String region;
  String flagUrl;
  String subRegion;
  int population;

  Country(this.name, this.capital, this.region, this.flagUrl, this.population,
      this.subRegion);

  Country.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.capital = json['capital'];
    this.region = json['Asia'];
    this.flagUrl = json['flag'];
    this.population = json['population'];
    this.subRegion = json['subregion'];
  }
}

class Answer extends Country {
  List<String> choices;
  String answer;
  String result = "";

  Answer(
      {String name,
      String capital,
      String region,
      String flagUrl,
      String subRegion,
      int population,
      this.choices,
      this.result,
      this.answer})
      : super(name, capital, region, flagUrl, population, subRegion);
}
