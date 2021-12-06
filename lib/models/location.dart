class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  Map<String, dynamic> toMap() => {
        'latitude': latitude,
        'longitude': longitude,
      };
}
