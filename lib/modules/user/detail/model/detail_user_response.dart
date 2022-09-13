import 'dart:convert';

DetailUserResponse userResponseFromJson(String str) =>
    DetailUserResponse.fromJson(json.decode(str));

class DetailUserResponse {
  DetailUserResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory DetailUserResponse.fromJson(Map<String, dynamic> json) =>
      DetailUserResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.umur,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  dynamic name;
  dynamic umur;
  String? createdAt;
  String? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        umur: json["umur"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}
