import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../api/api_key.dart';

class SearchBarScreen extends StatefulWidget {
  const SearchBarScreen({super.key});

  @override
  State<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  TextEditingController _controller = TextEditingController();

  var uid = const Uuid();
  String sessionToken = '12345';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (sessionToken == null) {
      sessionToken = uid.v4();
    }

    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String apiKey = googlePlaceApiKey;
    String baseURL = 'https://maps.googleapis.com/maps/api/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$apiKey&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    print(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        _placeList = jsonDecode(response.body.toString())['predictions'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SearchCity')),
      body: TextFormField(
        controller: _controller,
        decoration: InputDecoration(hintText: "Enter City Name"),
      ),
    );
  }
}
