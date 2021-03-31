import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/location.dart';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=19fba74d5e07bf0095e6f6b26f58ed94'));
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      int condition = decodedData(data)['weather'][0]['id'];
      print(condition);
      double temp = decodedData(data)['main']['temp'];
      print(temp);
      String city = decodedData(data)['name'];
      print(city);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
