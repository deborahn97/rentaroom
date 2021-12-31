class Rental {
  String? roomid;
  String? contact;
  String? title;
  String? description;
  String? price;
  String? deposit;
  String? state;
  String? area;
  DateTime? dateCreated;
  String? latitude;
  String? longitude;

  Rental(
    {
      required this.roomid,
      required this.contact,
      required this.title,
      required this.description,
      required this.price,
      required this.deposit,
      required this.state,
      required this.area,
      required this.dateCreated,
      required this.latitude,
      required this.longitude
    }
  );

  Rental.fromJson(Map<String, dynamic> json) {
    roomid = json['rooms']['roomid'];
    contact = json['rooms']['contact'];
    title = json['rooms']['title'];
    description = json['rooms']['description'];
    price = json['rooms']['price'];
    deposit = json['rooms']['deposit'];
    state = json['rooms']['state'];
    area = json['rooms']['area'];
    dateCreated = DateTime.parse(json['rooms']['date_created']);
    latitude = json['rooms']['latitude'];
    longitude = json['rooms']['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roomid'] = roomid;
    data['contact'] = contact;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['deposit'] = deposit;
    data['state'] = state;
    data['area'] = area;
    data['date_created'] = dateCreated;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
