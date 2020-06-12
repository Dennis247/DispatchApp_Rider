class Rider {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String password;

  Rider(
    this.id,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.password,
  );

  static List<Rider> ridertListFromJson(List collection) {
    List<Rider> riderlist =
        collection.map((json) => Rider.fromJson(json)).toList();
    return riderlist;
  }

  Rider.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fullName = json['fullName'],
        phoneNumber = json['phoneNumber'],
        email = json['email'],
        password = '*************';
}
