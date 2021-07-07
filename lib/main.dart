import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:http/http.dart" as http;
import 'dart:convert';

void main () => runApp(
    MaterialApp(
      title: 'Weather App',
      home:Home(),
    )
);

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }
}

class _HomeState extends State<Home>{
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather () async {
    http.Response response = await http.get(Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=Bambili&appid=c974e539aec51adad568a944da897caa"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['Speed'];

    });
  }
  @override
  void initState () {
    super.initState();
    this.getWeather();
  }
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.height,
              color: Colors.lightBlueAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 11.0),
                    child: Text(
                      "Currently In Cameroon(Bambili)",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                      temp !=null ? temp.toString() + "\u00B0" :"Loading",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 11.0),
                    child: Text(
                      currently != null ? currently.toString() : "Loading",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: ListView(
                    children: <Widget> [
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                        title: Text("Temperature"),
                        trailing: Text(temp != null ? temp.toString() + "\u00B0" : "Loading"),
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.cloud),
                        title: Text("Weather"),
                        trailing: Text(description !=null ? description.toString() : "Loading"),
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.sun),
                        title: Text("Humidity"),
                        trailing: Text(humidity != null ? humidity.toString() : "Loading"),
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.wind),
                        title: Text("Wind Speed"),
                        trailing: Text(windSpeed != null? windSpeed.toString() : "Loading"),
                      )
                    ],
                  ),

                )
            )
          ]
      ),
    );
  }
}
