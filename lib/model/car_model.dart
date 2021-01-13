import 'dart:convert';
import 'dart:typed_data';

class CarModel {
  final int id;
  final String name;
  final String releaseYear;
  final String color;
  final int price;
  final int modelId;
  final int power;
  Uint8List photo;

  CarModel(this.id, this.name, this.price, this.releaseYear, this.color,
      this.modelId, this.power, this.photo);

  CarModel.fromJson(Map<String, dynamic> json)
      : id = json["id_car"],
        name = json["name"],
        releaseYear = json["release_year"],
        color = json["color"],
        price = json["price"],
        modelId = json["model_id"],
        power = json["power"],
        photo = json["photo"] != null ? base64Decode(json["photo"]) : null;
}
