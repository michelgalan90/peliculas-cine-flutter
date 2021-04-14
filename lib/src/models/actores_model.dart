class Cast {
  List<Actor> actores = [];

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((mapa) {
      final actor = Actor.fromJsonMap(mapa);
      actores.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getFoto() {
    if (profilePath == null) {
      return 'https://png.pngitem.com/pimgs/s/22-224045_no-avatar-png-png-download-circle-transparent-png.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
