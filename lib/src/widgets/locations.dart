import 'package:flutter/material.dart';
import 'package:timugo/src/models/place.dart';
import 'package:dio/dio.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:async';

import 'package:timugo/src/widgets/divider_with_text.dart';


class NewTripLocationView extends StatefulWidget {


  NewTripLocationView({Key key,}) : super(key: key);

  @override
  _NewTripLocationViewState createState() => _NewTripLocationViewState();
}

class _NewTripLocationViewState extends State<NewTripLocationView> {
  TextEditingController _searchController = new TextEditingController();
  Timer _throttle;

  String _heading;
  List<Place> _placesList;
  final List<Place> _suggestedList = [
    Place("New York", 320.00),
    Place("Austin", 250.00),
    Place("Boston", 290.00),
    Place("Florence", 300.00),
    Place("Washington D.C.", 190.00),
  ];

  @override
  void initState() {
    super.initState();
    _heading = "Suggestions";
    _placesList = _suggestedList;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    if (_throttle?.isActive ?? false) _throttle.cancel();
    _throttle = Timer(const Duration(milliseconds: 500), () {
      getLocationResults(_searchController.text);
    });
  }

  void getLocationResults(String input) async {
    if (input.isEmpty) {
      setState(() {
        _heading = "Suggestions";
      });
      return;
    }

    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = '(regions)';
    String apiKey= 'AIzaSyC4Bg8apIFz5v6MVlTDQ6VFdJLlw61vLPg';

    String request = '$baseURL?input=$input&key=$apiKey&type=$type';
    Response response = await Dio().get(request);
    print(request);
    final predictions = response.data['predictions'];

    List<Place> _displayResults = [];

    for (var i=0; i < predictions.length; i++) {
      String name = predictions[i]['description'];
      double averageBudget = 200.0;
      _displayResults.add(Place(name, averageBudget));
    }

    setState(() {
      _heading = "Results";
      _placesList = _displayResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Trip - Location'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: new DividerWithText(
                dividerText: _heading,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _placesList.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildPlaceCard(context, index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlaceCard(BuildContext context, int index) {
    return Hero(
      tag: "SelectedTrip-${_placesList[index].name}",
      transitionOnUserGestures: true,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: Card(
            child: InkWell(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: AutoSizeText(_placesList[index].name,
                                    maxLines: 3,
                                    style: TextStyle(fontSize: 25.0)),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                  "Average Budget \$${_placesList[index].averageBudget.toStringAsFixed(2)}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Placeholder(
                        fallbackHeight: 80,
                        fallbackWidth: 80,
                      ),
                    ],
                  )
                ],
              ),
              onTap: () {
//widget.trip.title = _placesList[index].name;
                // that would need to be added to the Trip object
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => NewTripDateView(trip: widget.trip)),
                // );
              },
            ),
          ),
        ),
      ),
    );
  }
}

//RaisedButton(
//child: Text("Continue"),
//onPressed: () {
//trip.title = _titleController.text;
//Navigator.push(
//context,
//MaterialPageRoute(builder: (context) => NewTripDateView(trip: trip)),
//);
//},
//),