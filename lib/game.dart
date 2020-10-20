import 'dart:convert';
import 'dart:math';

import 'package:flag_quiz/country/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'colors.dart';

// ignore: must_be_immutable
class Game extends StatefulWidget {
  int length;

  @override
  _GameState createState() => _GameState();

  Game(this.length);
}

class _GameState extends State<Game> {
  List<Country> countryList;
  List<Answer> answerList = List<Answer>();
  var selectedChoices;
  int totalSuccess = 0;
  int totalFailed = 0;

  var isLoading = true;

  Future getCountryListData() async {
    String url = "https://restcountries.eu/rest/v2/all";
    var response = await http.get(url);

    var body = json.decode(response.body) as List;
    countryList = body.map((json) => Country.fromJson(json)).toList();
    setState(() {
      isLoading = false;
    });

    return countryList;
  }

  void fillQuizList(List<Country> countryList, List<Answer> answerList) {
    Random random = new Random();

    for (int i = 0; i < widget.length; i++) {
      int random1 = random.nextInt(countryList.length);
      int num = 0;
      List<String> choicesList = [countryList[random1].name];

      int i = 1;
      while (i < 4) {
        num = random.nextInt(countryList.length);
        if (choicesList.contains(countryList[num].name)) continue;
        choicesList.add(countryList[num].name);
        i++;
      }

      choicesList.shuffle();

      answerList.add(Answer(
        name: countryList[random1].name,
        capital: countryList[random1].capital,
        flagUrl: countryList[random1].flagUrl,
        region: countryList[random1].region,
        choices: choicesList,
      ));
    }
  }

  changeValue(val, index) {
    setState(() {
      selectedChoices = val;
      answerList[index].answer = val;
      if (answerList[index].name == val) {
        answerList[index].result = "Success";
        totalSuccess++;
      } else {
        answerList[index].result = "Failed";
        totalFailed++;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCountryListData().then((value) => fillQuizList(value, answerList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Country List",
          style: TextStyle(
              color: myColorListPrimary[4],
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
        centerTitle: true,
        backgroundColor: myColorListPrimary[0],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: EdgeInsets.only(top: 32, bottom: 32),
            child: Center(
                child: isLoading
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: answerList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                  side: BorderSide(
                                      color: myColorListPrimary[0],
                                      width: 0.3)),
                              color: myColorListPrimary[6],
                              shadowColor: myColorListPrimary[0],
                              elevation: 4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 32),
                                    child: Row(
                                      children: [
                                        (answerList[index].result == "Success")
                                            ? Text(
                                                "Success",
                                                style: TextStyle(
                                                    color: Colors.lightBlue,
                                                    fontSize: 24),
                                              )
                                            : ((answerList[index].result ==
                                                    "Failed")
                                                ? Text("Failed",
                                                    style: TextStyle(
                                                        color: Colors.redAccent,
                                                        fontSize: 24))
                                                : Text("",
                                                    style: TextStyle(
                                                        color: Colors.lightBlue,
                                                        fontSize: 24)))
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.only(left: 16, right: 16),
                                      width: MediaQuery.of(context).size.width *
                                          0.70,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      child: SvgPicture.network(
                                        answerList[index].flagUrl,
                                        fit: BoxFit.fill,
                                      )),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textWithRadio(
                                          answerList[index].choices[0],
                                          index,
                                          answerList[index].answer,
                                          answerList[index].name),
                                      textWithRadio(
                                          answerList[index].choices[1],
                                          index,
                                          answerList[index].answer,
                                          answerList[index].name),
                                      textWithRadio(
                                          answerList[index].choices[2],
                                          index,
                                          answerList[index].answer,
                                          answerList[index].name),
                                      textWithRadio(
                                          answerList[index].choices[3],
                                          index,
                                          answerList[index].answer,
                                          answerList[index].name),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent.withOpacity(0.5),
                border: Border.all(
                  color: myColorListPrimary[0],
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            //color: Colors.lightBlue.withOpacity(0.4),
            // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Icon(
                        Icons.done,
                        color: Colors.lightBlue,
                      ),
                      Text(
                        "Total Success: " + totalSuccess.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Icon(
                        Icons.close,
                        color: Colors.redAccent.withOpacity(0.5),
                      ),
                      Text(
                        "Total Failed: " + totalFailed.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48),
                  child: Row(
                    children: [
                      Text(
                        "Success ratio of total: " +
                            ((totalSuccess / widget.length) * 100)
                                .toStringAsFixed(0) +
                            " % ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget textWithRadio(value, index, answer, name) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16),
          child: Radio(
            value: value,
            groupValue: answer,
            activeColor: myColorListPrimary[0],
            onChanged: answer != null
                ? (val) {}
                : (val) {
                    changeValue(val, index);
                  },
          ),
        ),
        Container(
          child: Text(
            value.toString(),
            style: TextStyle(
                color: (answer != null && name != value)
                    ? Colors.redAccent.withOpacity(0.8)
                    : ((answer != null && value == name)
                        ? Colors.lightBlue
                        : ((answer != null && value != name)
                            ? Colors.redAccent.withOpacity(0.8)
                            : Colors.black)),
                fontSize: (answer != null && name != value)
                    ? 14
                    : ((answer != null && value == name)
                        ? 16
                        : ((answer != null && value != name) ? 14 : 14)),
                fontWeight: (answer != null && name != value)
                    ? FontWeight.w400
                    : ((answer != null && value == name)
                        ? FontWeight.w600
                        : ((answer != null && value != name)
                            ? FontWeight.w400
                            : FontWeight.w400))),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
