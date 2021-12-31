import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

import 'model/config.dart';
import 'model/rental.dart';

class RoomDetails extends StatefulWidget {
  final Rental rental;
  const RoomDetails({Key? key, required this.rental}) : super(key: key);

  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  @override
  Widget build(BuildContext context) {
    List<String> imgList = [
      Config.server + "/images/" + widget.rental.roomid! + "_1.jpg",
      Config.server + "/images/" + widget.rental.roomid! + "_2.jpg",
      Config.server + "/images/" + widget.rental.roomid! + "_3.jpg",
    ];

    if(widget.rental.latitude?.isEmpty ?? true) {
      widget.rental.latitude = "Unavailable";
    }
    if(widget.rental.longitude?.isEmpty ?? true) {
      widget.rental.longitude = "Unavailable";
    }

    late double scrHeight, scrWidth, resWidth;

    scrHeight = MediaQuery.of(context).size.height;
    scrWidth = MediaQuery.of(context).size.width;

    if (scrWidth <= 600) {
      resWidth = scrWidth;
    } else {
      resWidth = scrWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Room Details"),
      ),
      body: Center(
        child: SizedBox(
          width: resWidth * 2,
          height: scrHeight,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      widget.rental.title!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: resWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 0.6,
                      enlargeCenterPage: true,
                    ),
                    items: imgList.map(
                      (item) => Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,),
                        )
                      ),
                    ).toList(),
                  ),
                  SizedBox(height: scrHeight * 0.025),
                  Row(
                    children: [
                      const Icon(Icons.description_rounded),
                      SizedBox(width: resWidth * 0.02),
                      Flexible(
                        child: Text(
                          widget.rental.description!,
                          style: TextStyle(
                            fontSize: resWidth * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: scrHeight * 0.025),
                  Row(
                    children: [
                      const Icon(Icons.phone_rounded),
                      SizedBox(width: resWidth * 0.02),
                      Flexible(
                        child: Text(
                          widget.rental.contact!,
                          style: TextStyle(
                            fontSize: resWidth * 0.04,
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
                          "RM " + widget.rental.price! + " / month",
                          style: TextStyle(
                            fontSize: resWidth * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: scrHeight * 0.025),
                  Row(
                    children: [
                      const Icon(Icons.attach_money_rounded),
                      SizedBox(width: resWidth * 0.02),
                      Flexible(
                        child: Text(
                          "RM " + widget.rental.deposit! + " Deposit",
                          style: TextStyle(
                            fontSize: resWidth * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: scrHeight * 0.025),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded),
                      SizedBox(width: resWidth * 0.02),
                      Flexible(
                        child: Text(
                          widget.rental.state!,
                          style: TextStyle(
                            fontSize: resWidth * 0.04,
                          ),
                        ),
                      ),
                      SizedBox(width: resWidth * 0.25),
                      const Icon(Icons.location_city_rounded),
                      SizedBox(width: resWidth * 0.02),
                      Flexible(
                        child: Text(
                          widget.rental.area!,
                          style: TextStyle(
                            fontSize: resWidth * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: scrHeight * 0.025),
                  Row(
                    children: [
                      const Icon(Icons.location_searching_rounded),
                      SizedBox(width: resWidth * 0.02),
                      Flexible(
                        child: Text(
                          "Latitude: " + widget.rental.latitude! + "     Longitude: " + widget.rental.longitude!,
                          style: TextStyle(
                            fontSize: resWidth * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: scrHeight * 0.025),
                  Row(
                    children: [
                      const Icon(Icons.post_add_rounded),
                      SizedBox(width: resWidth * 0.02),
                      Flexible(
                        child: Text(
                          "Posted on: " + DateFormat('d MMM yyyy hh:mm a').format(widget.rental.dateCreated!),
                          style: TextStyle(
                            fontSize: resWidth * 0.04,
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
      ),
    );
  }
}
