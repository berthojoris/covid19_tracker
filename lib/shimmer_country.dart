import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCountry extends StatelessWidget {
  const ShimmerCountry({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerWidth = 280;
    double containerHeight = 15;
    return Scaffold(
      body: SingleChildScrollView(
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          enabled: true,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                height: 60,
                                width: 60,
                                color: Colors.grey,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: containerHeight,
                                    width: containerWidth,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    height: containerHeight,
                                    width: containerWidth * 0.75,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    height: containerHeight,
                                    width: containerWidth * 0.50,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
