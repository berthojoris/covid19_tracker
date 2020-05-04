import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Color(0xff202c3b),
      primaryIconTheme: IconThemeData(color: Colors.white),
      primaryColorBrightness: Brightness.dark,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          decoration: TextDecoration.none,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          decoration: TextDecoration.none,
        ),
      ),
      cursorColor: Colors.white,
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final nf = NumberFormat("#,###");
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element['country'].toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
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
                      Text(
                        suggestionList[index]['country'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      CachedNetworkImage(
                        height: 50,
                        width: 60,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        imageUrl: suggestionList[index]['countryInfo']['flag'],
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
                                .format(suggestionList[index]['cases'])
                                .toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        'ACTIVE: ' +
                            nf
                                .format(suggestionList[index]['active'])
                                .toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        'RECOVERED: ' +
                            nf
                                .format(suggestionList[index]['recovered'])
                                .toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'DEATHS: ' +
                            nf
                                .format(suggestionList[index]['deaths'])
                                .toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
