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
  List<String> filteredStations = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    fetchAllTrainStations();
    _searchFocusNode.addListener(_onSearchFocusChange);
  }

  void fetchAllTrainStations() async {
    allTrainStations = await TrainLine.fetchAllStationsName();
    filteredStations = List.from(allTrainStations);
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

  void _onSearchFocusChange() {
    if (!_searchFocusNode.hasFocus) {
      setState(() {
        filteredStations.clear();
      });
    }
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
          backgroundColor: CustomColors.background.withGreen(120), // This adds a red tint to the background color
          title: TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            onChanged: (value) {
              setState(() {
                searchedTrainLine = value;
                if (searchedTrainLine.length >= 3) {
                  filteredStations = allTrainStations.where((station) => station.toLowerCase().contains(searchedTrainLine.toLowerCase())).toList();
                } else {
                  filteredStations.clear();
                  futureTrainLines = Future.value([]);
                }
              });
            },
            onSubmitted: (value) {
              FocusScope.of(context).unfocus();
              if (value.length >= 3) {
                fetchTrainLines();
              } else {
                futureTrainLines = Future.value([]);
              }
            },
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              fetchTrainLines();
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search), // This adds a search icon to the left of the search bar
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Suggestions list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredStations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredStations[index]),
                    onTap: () {
                      setState(() {
                        searchedTrainLine = filteredStations[index];
                        _searchController.value = TextEditingValue(
                          text: searchedTrainLine,
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: searchedTrainLine.length),
                          ),
                        );
                        filteredStations.clear();
                        FocusScope.of(context).unfocus();
                        fetchTrainLines();
                      });
                    },
                  );
                },
              ),
              // Rest of the body
              FutureBuilder<List<TrainLine>>(
                future: futureTrainLines,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting && futureTrainLines != null) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Display the actual error message
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Text(
                          'No trains found.',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                    }
                  } else {
                    return const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text(
                        'Nothing to display.',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}