class Profile {
  String name;
  String lastName;
  String email;
  String id;
  String picture;

  Profile({
    this.name,
    this.lastName,
    this.picture,
    this.email,
    this.id,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => new Profile(
    name: json["name"],
    lastName: json["last_name"],
    email: json["email"],
    picture: json["picture"]["data"]["url"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "last_name": lastName,
    "email": email,
    "picture": picture,
    "id": id,
  };
}
