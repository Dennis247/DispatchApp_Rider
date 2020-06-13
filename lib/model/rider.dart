class Rider {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String password;
  final bool hasActiveDispatch;

  Rider(this.id, this.fullName, this.phoneNumber, this.email, this.password,
      this.hasActiveDispatch);

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
        hasActiveDispatch = json['hasActiveDispatch'],
        password = '*************';
}
