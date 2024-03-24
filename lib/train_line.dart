import 'dart:convert';
import 'package:http/http.dart' as http;

class TrainLine {
  final String trainShortName;
  final String trainLongName;
  final String time;
  final String trip_id;

  const TrainLine({
    required this.trainShortName,
    required this.trainLongName,
    required this.time,
    required this.trip_id
  });

  factory TrainLine.fromJson(Map<String, dynamic> json) {
    return TrainLine(
        trainShortName: json['trainShortName'] as String,
        trainLongName: json['trainLongName'] as String,
        time: json['time'] as String,
        trip_id: json['trip_id'] as String
    );
  }

  static Future<List<TrainLine>> getTrainLines(String searchedTrainLine) async {
    final response = await http
        .get(Uri.parse('http://84.46.255.122:80/api/getAllDepartureFromStation/$searchedTrainLine'));

    if (response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body) as List<dynamic>;
      return list.map((item) => TrainLine.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load $searchedTrainLine line.');
    }
  }

  static Future<List<String>> fetchAllStationsName() async {
    final response = await http.get(
        Uri.parse('http://84.46.255.122:80/api/getAllStations'));

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body) as List<dynamic>);
    } else {
      throw Exception('Failed to load train stations.');
    }
  }
}