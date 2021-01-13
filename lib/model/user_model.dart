
class UserModel {
  final int id;
  final String name;
  final String patronymic;
  final String phone;
  final String surname;
 

  UserModel(this.id, this.name, this.patronymic, this.phone, this.surname);

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        patronymic = json["patronymic"],
        phone = json["phone"],
        surname = json["surname"];
}
