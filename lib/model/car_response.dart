
import 'car_model.dart';

class CarsResponse {
  final List<CarModel> cars;
  final String error;

  CarsResponse(this.cars, this.error);

  CarsResponse.fromJson(Map<String, dynamic> json)
      : cars =
            (json["cars_list"] as List).map((i) => new CarModel.fromJson(i)).toList(),
        error = "";

  CarsResponse.withError(String errorValue)
      : cars = List(),
        error = errorValue;
}