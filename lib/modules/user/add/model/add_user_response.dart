import 'dart:convert';

AddUserResponse userResponseFromJson(String str) => AddUserResponse.fromJson(json.decode(str));

String userResponseToJson(AddUserResponse data) => json.encode(data.toJson());

class AddUserResponse {
  AddUserResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory AddUserResponse.fromJson(Map<String, dynamic> json) => AddUserResponse(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.name,
    required this.umur,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  dynamic name;
  dynamic umur;
  DateTime updatedAt;
  DateTime createdAt;
  dynamic id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    umur: json["umur"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "umur": umur,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
