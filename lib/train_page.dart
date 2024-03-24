import 'package:application_jam/custom_colors.dart';
import 'package:application_jam/train_line.dart';
import 'package:flutter/material.dart';

class TrainPage extends StatefulWidget {
  final bool isDark;

  const TrainPage({Key? key, required this.isDark}) : super(key: key);

  @override
  _TrainPageState createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {
  Future<List<TrainLine>>? futureTrainLines;
  String searchedTrainLine = 'Libercourt';
  List<String> allTrainStations = [];

  @override
  void initState() {
    super.initState();
    fetchAllTrainStations();
  }

  void fetchAllTrainStations() async {
    allTrainStations = await TrainLine.fetchAllStationsName();
  }

  void fetchTrainLines() {
    futureTrainLines = TrainLine.getTrainLines(searchedTrainLine).timeout(const Duration(seconds: 10), onTimeout: () {
      print('Failed to fetch train lines: request timed out');
      return Future.value([]);
    }).catchError((error) {
      print('Failed to fetch train lines: $error');
      if (error.toString().contains('Connection refused')) {
        print('Could not establish a connection to the server. Please check your network connection and try again.');
      }
      return Future.value([]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: CustomColors.background,
        appBar: AppBar(
          backgroundColor: CustomColors.background,
          title: TextField(
            onChanged: (value) {
              setState(() {
                searchedTrainLine = value;
                fetchAllTrainStations();
              });
            },
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              fetchTrainLines();
            },
            onSubmitted: (value) {
              FocusScope.of(context).unfocus();
              fetchTrainLines();
            },
          ),
        ),
        body: Center(
          child: FutureBuilder<List<TrainLine>>(
            future: futureTrainLines,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 0),
                      child: ListTile(
                        leading: const Icon(Icons.train),
                        title: Text(snapshot.data![index].trainShortName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(snapshot.data![index].trainLongName),
                            Text(snapshot.data![index].time),
                          ],
                        ),
                        trailing: const Icon(Icons.timelapse),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // Display the actual error message
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}