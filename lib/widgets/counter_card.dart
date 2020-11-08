import 'package:flag_quiz/colors.dart';
import 'package:flag_quiz/country/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CountryCard extends StatefulWidget {
  Country country;

  @override
  _CountryCardState createState() => _CountryCardState();

  CountryCard(this.country);
}

class _CountryCardState extends State<CountryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Country name: " + widget.country.name,
                        style: TextStyle(
                            color: myColorListPrimary[0],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Capital: " + widget.country.capital,
                        style: TextStyle(
                          color: myColorListPrimary[0],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Population: " + widget.country.population.toString(),
                        style: TextStyle(
                          color: myColorListPrimary[0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: myColorListPrimary[1].withOpacity(0.2))),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: SvgPicture.network(
                    widget.country.flagUrl,
                    fit: BoxFit.fill,
                    allowDrawingOutsideViewBox: false,
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
