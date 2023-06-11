class Location {
  String markerid;
  double lat;
  double long;
  String title;

  Location({
    required this.markerid,
    required this.lat,
    required this.long,
    required this.title
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['title'] = this.title;
    return data;
  }
}