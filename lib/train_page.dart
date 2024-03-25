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
  TimeOfDay? pickedTime;

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
    futureTrainLines = TrainLine.getTrainLines(searchedTrainLine).then((trainLines) {
      trainLines.sort((a, b) => a.time.compareTo(b.time));
      if (pickedTime != null) {
        String pickedTimeString = '${pickedTime!.hour.toString().padLeft(2, '0')}:${pickedTime!.minute.toString().padLeft(2, '0')}';
        trainLines = trainLines.where((trainLine) => trainLine.time.compareTo(pickedTimeString) >= 0).toList();
      }
      return trainLines;
    }).timeout(const Duration(seconds: 10), onTimeout: () {
      return Future.value([]);
    }).catchError((error) {
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
          backgroundColor: CustomColors.background,
          title: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time, color: Colors.white),
                  onPressed: () async {
                    pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      fetchTrainLines();
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.black.withOpacity(0.5),
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.white),
              ),
              onChanged: (value) {
                setState(() {
                  searchedTrainLine = value;
                  if (searchedTrainLine.length >= 3) {
                    filteredStations = allTrainStations.where((station) => station.toLowerCase().contains(searchedTrainLine.toLowerCase())).toList();
                  } else {
                    filteredStations.clear();
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
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredStations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Padding (
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                      filteredStations[index],
                      style: const TextStyle(
                        color: Colors.black, // Change the color to make the text more visible
                        fontSize: 20.0, // Increase the font size
                        fontWeight: FontWeight.bold, // Make the text bold
                      ),
                    ),
                    ),
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
              FutureBuilder<List<TrainLine>>(
                future: futureTrainLines,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting && futureTrainLines != null) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
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
                              onTap: () async {
                                List<Station> crossedStations = await TrainLine.getCrossedStations(snapshot.data![index].trip_id);
                                crossedStations.sort((a, b) => a.time.compareTo(b.time));
                                double heightFactor = crossedStations.length * 0.1;
                                heightFactor = heightFactor > 0.9 ? 0.9 : heightFactor;

                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    double heightFactor = crossedStations.length * 0.1;
                                    heightFactor += 0.1;
                                    heightFactor = heightFactor > 0.9 ? 0.9 : heightFactor;

                                    return FractionallySizedBox(
                                      heightFactor: heightFactor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                snapshot.data![index].trainShortName,
                                                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                snapshot.data![index].trainLongName,
                                                style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
                                              ),
                                              const SizedBox(height: 20.0),
                                              for (int i = 0; i < crossedStations.length; i++) ...[
                                                ListTile(
                                                  leading: const Icon(Icons.train),
                                                  title: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            crossedStations[i].name,
                                                            style: TextStyle(
                                                              color: i == 0 ? Colors.green : (i == crossedStations.length - 1 ? Colors.red : null),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                i == 0 ? 'Departure' : (i == crossedStations.length - 1 ? 'Arrival' : ''),
                                                                style: const TextStyle(fontSize: 12.0),
                                                              ),
                                                              Icon(
                                                                i == 0 ? Icons.departure_board : (i == crossedStations.length - 1 ? Icons.flight_land : null),
                                                                size: 16.0,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        crossedStations[i].time,
                                                        style: const TextStyle(fontSize: 12.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (i != crossedStations.length - 1)
                                                  const Icon(Icons.arrow_downward, size: 24.0, color: Colors.blue),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
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