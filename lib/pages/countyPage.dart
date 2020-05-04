import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:tgd_covid_tracker/pages/search.dart';
import 'package:tgd_covid_tracker/shimmer_country.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;
  final nf = NumberFormat("#,###");

  fetchCountryData() async {
    if (this.mounted) {
      http.Response response =
          await http.get('https://corona.lmao.ninja/v2/countries');
      setState(() {
        countryData = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          countryData == null
              ? Container()
              : searchButton(
                  context,
                  countryData,
                ),
        ],
        title: Text('Country Stats'),
      ),
      body: countryData == null
          ? Center(
              child: ShimmerCountry(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    height: 90,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 200,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  countryData[index]['country'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Image.network(
                                countryData[index]['countryInfo']['flag'],
                                height: 50,
                                width: 60,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'CONFIRMED: ' +
                                      nf
                                          .format(countryData[index]['cases'])
                                          .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                Text(
                                  'ACTIVE: ' +
                                      nf
                                          .format(countryData[index]['active'])
                                          .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  'RECOVERED: ' +
                                      nf
                                          .format(
                                              countryData[index]['recovered'])
                                          .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  'DEATHS: ' +
                                      nf
                                          .format(countryData[index]['deaths'])
                                          .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: countryData == null ? 0 : countryData.length,
            ),
    );
  }
}

Widget searchButton(BuildContext context, countryData) {
  return IconButton(
    icon: Icon(Icons.search),
    onPressed: () {
      showSearch(context: context, delegate: Search(countryData));
    },
  );
}
