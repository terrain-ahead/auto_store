

class MarkModel {
  final int id;
  final String name;
  final String manufacturerCountry;


  MarkModel(this.id, this.name, this.manufacturerCountry);

  MarkModel.fromJson(Map<String, dynamic> json)
      : id = json["id_brand"],
        name = json["name"],
        manufacturerCountry = json["manufacturer_country"];
}