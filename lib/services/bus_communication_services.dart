import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigo_tracker/bus_info_state.dart';
import 'package:navigo_tracker/models/BusInfo.dart';
import 'package:navigo_tracker/models/bus_position.model.dart';

class BusCommunicationServices {
  static Future<void> sendBusInfo(BusInfo busInfo) async {
    //   try {
    //     final url = 'your_api_url_here';
    //     final response = await http.post(
    //       Uri.parse(url),
    //       body: json.encode(busInfo),
    //       headers: {'Content-Type': 'application/json'},
    //     );

    //     if (response.statusCode == 200) {
    //       // Request was successful, handle response if needed
    //       print('Bus info sent successfully!');
    //     } else {
    //       // Request failed, handle error if needed
    //       print('Failed to send bus info. Error: ${response.statusCode}');
    //     }
    //   } catch (error) {
    //     // Handle any exceptions or errors
    //     print('An error occurred while sending bus info: $error');
    //   }
    // }
    print(busInfo);
  }

  static Future<void> sendBusCoordinates(
      BusPosition busPosition, BusInfo busState) async {
    final docUser = FirebaseFirestore.instance
        .collection('BusLocation')
        .doc(busPosition.busId);

    // Get the current document snapshot
    final snapshot = await docUser.get();

    // Retrieve the current counter value or set it to 0 if it doesn't exist
    final currentCounter =
        snapshot.exists ? (snapshot.data()!['counter'] ?? 0) : 0;

    // Increment the counter
    final newCounter = currentCounter + 1;

    // Update the document with the new counter value and other fields
    final jsonData = {
      'busNumber': busPosition.busNumber,
      'busId': busPosition.busId,
      'latitude': busPosition.latitude,
      'longitude': busPosition.longitude,
      'timestamp': FieldValue.serverTimestamp(),
      'counter': newCounter,
    };
    await docUser.set(jsonData);
  }
  // static Future<void> sendBusCoordinates(
  //     BusPosition busPosition, BusInfo busState) async {
  //   final docUser = FirebaseFirestore.instance
  //       .collection('BusLocation')
  //       .doc(busPosition.busId);
  //   final jsonData = {
  //     'busNumber': busPosition.busNumber,
  //     'busId': busPosition.busId,
  //     'latitude': busPosition.latitude,
  //     'longitude': busPosition.longitude,
  //     'timestamp': FieldValue.serverTimestamp(),
  //     'driverName': busState.name
  //   };
  //   await docUser.set(jsonData);
  // }
  //   static Future<void> sendBusCoordinates(
  //     BusPosition busPosition, BusInfo busState) async {

  //   final docUser = FirebaseFirestore.instance.collection('BusLocation');
  //   final jsonData = {
  //     'BusNumber': busPosition.busNumber,
  //     'BusID': busPosition.busId,
  //     'latitude': busPosition.latitude,
  //     'longitude': busPosition.longitude
  //   };
  //   await docUser.add(jsonData);
  // }

  static Future<List<dynamic>> getBusStopsFromJson() async {
    return await loadJsonData();
  }

  static Future<List<dynamic>> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/busStops.json');
    var jsonData = json.decode(jsonString);
    return jsonData['bus_stops'];
  }
}
