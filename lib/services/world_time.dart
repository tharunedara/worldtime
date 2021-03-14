import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class  WorldTime{

  String location; // location name for ui
  String time;// the time in that location
  String flag; //url to asset flag icon
  String url; //location url for api endpoints
  bool isDayTime;// true or false for day or night



  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async{

    try{

      // make the request
      Response response =  await get(Uri.parse('https://www.worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      String hours = offset.substring(1,3);
      String minutes = offset.substring(4,6);
      //print(datetime);
      //print(offset);
      //print(hours);
      //print(minutes);

      // create date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(hours), minutes: int.parse(minutes) ));
      //print(now);

      // set time property
      time = DateFormat.jm().format(now);
      isDayTime = now.hour > 6 && now.hour< 18 ? true: false;


    }
    catch(e){
      print("Caught error: $e");
      time = "Could not get time data";


    }

  }



}
