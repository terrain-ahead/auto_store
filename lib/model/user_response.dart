
import 'package:kursach_avto_app/model/user_model.dart';

class UserResponse {
  final List<UserModel> clients;
  final String error;

  UserResponse(this.clients, this.error);

  UserResponse.fromJson(Map<String, dynamic> json)
      : clients =
            (json["client_list"] as List).map((i) => new UserModel.fromJson(i)).toList(),
        error = "";

  UserResponse.withError(String errorValue)
      : clients = List(),
        error = errorValue;
}