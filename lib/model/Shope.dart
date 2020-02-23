// To parse this JSON data, do
//
//     final shope = shopeFromJson(jsonString);

import 'dart:convert';

Shope shopeFromJson(String str) => Shope.fromJson(json.decode(str));

String shopeToJson(Shope data) => json.encode(data.toJson());

class Shope {
  String id;
  String file1;
  String file2;
  String title;
  String description;
  String field1;
  String field2;
  String field3;
  String field4;
  String field6;
  String field7;
  String field8;

  Shope({
    this.id,
    this.file1,
    this.file2,
    this.title,
    this.description,
    this.field1,
    this.field2,
    this.field3,
    this.field4,
    this.field6,
    this.field7,
    this.field8,
  });

  factory Shope.fromJson(Map<String, dynamic> json) => Shope(
    id: json["id"],
    file1: json["file_1"],
    file2: json["file_2"],
    title: json["title"],
    description: json["description"],
    field1: json["field_1"],
    field2: json["field_2"],
    field3: json["field_3"],
    field4: json["field_4"],
    field6: json["field_6"],
    field7: json["field_7"],
    field8: json["field_8"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file_1": file1,
    "file_2": file2,
    "title": title,
    "description": description,
    "field_1": field1,
    "field_2": field2,
    "field_3": field3,
    "field_4": field4,
    "field_6": field6,
    "field_7": field7,
    "field_8": field8,
  };
}
