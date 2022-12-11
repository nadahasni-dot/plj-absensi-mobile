class UserModel {
  UserModel({
    required this.id,
    required this.nip,
    required this.name,
    required this.email,
    required this.avatar,
    required this.createdAt,
  });

  int id;
  String nip;
  String name;
  String email;
  String? avatar;
  DateTime createdAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        nip: json["nip"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nip": nip,
        "name": name,
        "email": email,
        "avatar": avatar,
        "created_at": createdAt.toIso8601String(),
      };
}
