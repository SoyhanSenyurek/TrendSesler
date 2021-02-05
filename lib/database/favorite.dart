class Favorite {
  int id;
  int firebaseId;
  Favorite({this.id, this.firebaseId});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["firebaseId"] = firebaseId;
    return map;
  }

  Favorite.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    firebaseId = map["firebaseId"];
  }
}
