class ModelModel {
   int id;
   int brandId;
   String name;
   String brandName;
   String possibleColor;
   String releaseYear;

  ModelModel();

  // ModelModel(
  //   this.id,
  //   this.brandId,
  //   this.name,
  //   this.possibleColor,
  //   this.releaseYear,
  // );

  ModelModel.fromJson(Map<String, dynamic> json)
      : id = json["id_model"],
        brandId = json["brand_id"],
        brandName = json["brand_name"],
        name = json["name"],
        possibleColor = json["possible_color"],
        releaseYear = json["release_year"];
}
