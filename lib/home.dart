import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'game.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedRadio = 15;

  changeValue(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Country Quiz",
          style: TextStyle(
              color: myColorListPrimary[4], fontWeight: FontWeight.bold,letterSpacing: 2),
        ),
        centerTitle: true,
        backgroundColor: myColorListPrimary[0],
        elevation: 0,
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                    decoration: BoxDecoration(
                        color: myColorListPrimary[4].withOpacity(0.4),
                        border: Border.all(
                            color: myColorListPrimary[0], width: 0.6),
                        borderRadius: BorderRadius.circular(32)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Flag Competition",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "Choose number of country",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            textWithRadio(5),
                            textWithRadio(10),
                            textWithRadio(15),
                            textWithRadio(25),
                            textWithRadio(50)
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
                    onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){return FlagGame(selectedRadio);}));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),side: BorderSide(color: myColorListPrimary[0])),
                    child: Text("Start Flag Competition",style: TextStyle(color: myColorListPrimary[4],fontSize: 20),),elevation: 3,
                    color: myColorListPrimary[1].withOpacity(0.8),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget textWithRadio(value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(value.toString()),
        ),
        Radio(
          value: value,
          groupValue: selectedRadio,
          activeColor: myColorListPrimary[0],
          onChanged: (val) {
            changeValue(val);
          },
        )
      ],
    );
  }
}
