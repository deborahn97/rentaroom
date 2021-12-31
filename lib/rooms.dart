import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rentaroom/room_details.dart';

import 'model/config.dart';
import 'model/rental.dart';

class Rooms extends StatefulWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  List roomList = [];
  String results = "Results Found: ";
  int numRooms = 0;

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  @override
  Widget build(BuildContext context) {
    late double scrHeight, scrWidth, resWidth;
    late int gridCount;

    scrHeight = MediaQuery.of(context).size.height;
    scrWidth = MediaQuery.of(context).size.width;

    if (scrWidth <= 600) {
      resWidth = scrWidth;
      gridCount = 2;
    } else {
      resWidth = scrWidth * 0.75;
      gridCount = 3;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Rent A Room"),
      ),
      body: Center(
        child: SizedBox(
          width: resWidth * 2,
          height: scrHeight,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "Available Rooms for Rent",
                  style: TextStyle(
                    fontSize: resWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: scrHeight * 0.035),
                Text(
                  results + numRooms.toString(),
                  style: TextStyle(
                    fontSize: resWidth * 0.04,
                  ),
                ),
                SizedBox(height: scrHeight * 0.035),
                Expanded(
                  child: GridView.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: gridCount,
                    children: List.generate(
                      numRooms,
                      (index) {
                        return SingleChildScrollView(
                          child: Card(
                            elevation: 5,
                            child: InkWell(
                              onTap: (() => {
                                    _roomDetails(index),
                                  }),
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            roomList[index]['title'].toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: resWidth * 0.0475,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF2962FF),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: scrHeight * 0.025),
                                    Row(
                                      children: [
                                        const Icon(Icons.sell_rounded),
                                        SizedBox(width: resWidth * 0.02),
                                        Flexible(
                                          child: Text(
                                            "RM " + roomList[index]['price'] + "/month",
                                            style: TextStyle(
                                              fontSize: resWidth * 0.035,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                            Icons.attach_money_rounded),
                                        SizedBox(width: resWidth * 0.02),
                                        Flexible(
                                          child: Text(
                                            "RM " + roomList[index]['deposit'] + " Deposit",
                                            style: TextStyle(
                                              fontSize: resWidth * 0.035,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                            Icons.location_city_rounded),
                                        SizedBox(width: resWidth * 0.02),
                                        Flexible(
                                          child: Text(
                                            roomList[index]['area'] + ", " + roomList[index]['state'],
                                            style: TextStyle(
                                              fontSize: resWidth * 0.035,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loadRooms() {
    http
        .post(Uri.parse(Config.server + "/php/load_rooms.php"))
        .then((response) {
      if (response.statusCode == 200 && response.body != "failed") {
        var parsedJson = json.decode(response.body);
        roomList = parsedJson['data']['rooms'];
        
        setState(() {
          numRooms = roomList.length;
        });
        
      } else {
        setState(() {
          results = "No results";
        });
      }
    });
  }

  _roomDetails(int index) async {
    Rental rental = Rental(
      roomid: roomList[index]['roomid'],
      contact: roomList[index]['contact'],
      title: roomList[index]['title'],
      description: roomList[index]['description'],
      price: roomList[index]['price'],
      deposit: roomList[index]['deposit'],
      state: roomList[index]['state'],
      area: roomList[index]['area'],
      dateCreated: DateTime.tryParse(roomList[index]['date_created']),
      latitude: roomList[index]['latitude'],
      longitude: roomList[index]['longitude'],
    );

    await Get.to(() => RoomDetails(rental: rental));
  }
}
