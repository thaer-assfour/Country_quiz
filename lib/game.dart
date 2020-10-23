import 'dart:convert';
import 'dart:math';

import 'country/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'colors.dart';

// ignore: must_be_immutable
class FlagGame extends StatefulWidget {
  int length;

  @override
  _FlagGameState createState() => _FlagGameState();

  FlagGame(this.length);
}

class _FlagGameState extends State<FlagGame> {
  List<Country> countryList;
  List<Answer> answerList = List<Answer>();
  var selectedChoices;
  int totalSuccess = 0;
  int totalFailed = 0;
  int totalNotAnswered;

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
        totalNotAnswered--;
      } else {
        answerList[index].result = "Failed";
        totalFailed++;
        totalNotAnswered--;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalNotAnswered = widget.length;
    getCountryListData().then((value) => fillQuizList(value, answerList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Country Quiz List",
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Let's Start the Competition",
              style: TextStyle(fontSize: 24, color: myColorListPrimary[0]),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.60,
            padding: EdgeInsets.only(top: 32, bottom: 0),
            child: Center(
                child: isLoading
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: answerList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: myColorListPrimary[0],
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8.0),
                                              topLeft: Radius.circular(8.0),
                                            )),
                                        padding: const EdgeInsets.only(
                                            left: 6,
                                            right: 6,
                                            top: 4,
                                            bottom: 4),
                                        child: Text(
                                          "  " +
                                              (index + 1).toString() +
                                              "   of   " +
                                              widget.length.toString() +
                                              "  ",
                                          style: TextStyle(
                                              color: myColorListPrimary[4]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.only(
                                      top: 0, bottom: 8, left: 0, right: 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(16.0),
                                          bottomLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0)),
                                      side: BorderSide(
                                          color: myColorListPrimary[0],
                                          width: 0.3)),
                                  color: myColorListPrimary[6],
                                  shadowColor: myColorListPrimary[0],
                                  elevation: 4,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 32),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12, bottom: 8, left: 0),
                                          child: Row(
                                            children: [
                                              (answerList[index].result ==
                                                      "Success")
                                                  ? Row(
                                                      children: [
                                                        CircleAvatar(
                                                          child: Icon(
                                                            Icons.done,
                                                            size: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.015,
                                                            color: Colors.white,
                                                          ),
                                                          backgroundColor:
                                                              Colors.lightBlue,
                                                          radius: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.013,
                                                        ),
                                                        Text(
                                                          " Success",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    )
                                                  : ((answerList[index]
                                                              .result ==
                                                          "Failed")
                                                      ? Row(
                                                          children: [
                                                            CircleAvatar(
                                                              child: Icon(
                                                                Icons.close,
                                                                size: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.015,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              backgroundColor:
                                                                  Colors
                                                                      .redAccent,
                                                              radius: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.013,
                                                            ),
                                                            Text(
                                                              " Failed",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .redAccent,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                            ),
                                                          ],
                                                        )
                                                      : Text(
                                                          "Choose the correct answer :",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              color:
                                                                  myColorListPrimary[
                                                                      0],
                                                              fontSize: 18)))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 16,
                                              right: 16,
                                              bottom: 8,
                                              top: 8),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.25,
                                          child: SvgPicture.network(
                                            answerList[index].flagUrl,
                                            fit: BoxFit.fill,
                                            allowDrawingOutsideViewBox: false,
                                            width: double.infinity,
                                            height: double.infinity,
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
                                )
                              ],
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
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Icon(
                        Icons.hourglass_empty,
                        color: Colors.orange,size: 22,
                      ),
                      Text(
                        "Total Not Answered: " + totalNotAnswered.toString(),
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
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
            overflow: TextOverflow.clip,
            softWrap: false,
          ),
        ),
      ],
    );
  }
}
