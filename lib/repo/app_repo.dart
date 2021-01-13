import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:kursach_avto_app/model/car_response.dart';
import 'package:kursach_avto_app/model/mark_response.dart';
import 'package:kursach_avto_app/model/model_response.dart';
import 'package:kursach_avto_app/model/user_response.dart';

class AppRepository {
  static String mainUrl = "https://luxury-auto.herokuapp.com";
  var getCarsUrl = "$mainUrl/cars";
  var marksUrl = "$mainUrl/brands";
  var modelUrl = "$mainUrl/models";
  var topTenUrl = "$mainUrl/top_10_luxury_auto";
  var carsOfOneModelUrl = "$mainUrl/cars_of_one_model";
  var modelsOfOneYearUrl = "$mainUrl/models_of_one_year";
  var searchUrl = "$mainUrl/search";
  var clientsUrl = "$mainUrl/clients";
  var ordersUrl = "$mainUrl/orders";

  var headers = {"Content-Type": "application/json","Accept":"*/*"};

  final Dio _dio = Dio();

  Future<CarsResponse> getAllCars() async {
    try {
      Response response = await _dio.get(getCarsUrl);
      return CarsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CarsResponse.withError("$error");
    }
  }

  Future<UserResponse> getAllUser() async {
    try {
      Response response = await _dio.get(clientsUrl);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

  Future<CarsResponse> getTopTenCars() async {
    try {
      Response response = await _dio.get(topTenUrl);
      return CarsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CarsResponse.withError("$error");
    }
  }

  Future<CarsResponse> getModelCars(int modelId) async {
    try {
      Response response = await _dio.get(carsOfOneModelUrl + "/$modelId");
      return CarsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CarsResponse.withError("$error");
    }
  }

  Future<CarsResponse> getUserOrdersCar(int userID) async {
    try {
      Response response = await _dio.get(ordersUrl + "/$userID");
      return CarsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CarsResponse.withError("$error");
    }
  }

  Future<CarsResponse> getByNameCars(String name) async {
    name = name.replaceAll(" ", "_");
    try {
      Response response = await _dio.get(searchUrl + "/$name");
      return CarsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CarsResponse.withError("$error");
    }
  }

  Future<MarkResponse> getAllMarks() async {
    try {
      Response response = await _dio.get(marksUrl);
      print(response.data);
      return MarkResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MarkResponse.withError("$error");
    }
  }

  Future<bool> addMark(String nameMark, String nameCity) async {
    var body = {
      "name": "$nameMark",
      "manufacturer-country": "$nameCity",
    };
    try {
      Response response = await _dio.post(marksUrl,
          data: body, options: Options(headers: headers));
      print(response.data);
      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }

  Future<bool> removeMark(int idMark) async {
    try {
      Response response = await _dio.delete(marksUrl + "/$idMark");
      print(response.data);
      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }
  //===============================================================

  Future<ModelResponse> getAllModels() async {
    try {
      Response response = await _dio.get(modelUrl);
      print(response.data);
      return ModelResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ModelResponse.withError("$error");
    }
  }

  Future<bool> addModel(int brandId, String nameModel, String nameColor,
      String releaseYear) async {
    var body = {
      "name": "$nameModel",
      "possible_colors": "$nameColor",
      "release_year": "$releaseYear",
      "brand_id": brandId,
    };
    try {
      Response response = await _dio.post(modelUrl,
          data: body, options: Options(headers: headers));
      print(response.data);
      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }

  Future<bool> removeModel(int idModel) async {
    try {
      Response response = await _dio.delete(modelUrl + "/$idModel");
      print(response.data);
      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }

  Future<bool> removeCars(int idCars) async {
    try {
      Response response = await _dio.delete(getCarsUrl + "/$idCars");
      print(response.data);
      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }

  Future<bool> addCars(int modelID, File photo, String color, String power,
      String releaseYear, String price) async {
    List<int> imageBytes = photo.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    var body = {
      "color": "$color",
      "power": "$power",
      "photo": "$base64Image",
      "release_year": "$releaseYear",
      "model_id": "$modelID",
      "price": "$price"
    };
    try {
      Response response = await _dio.post(getCarsUrl,
          data: body, options: Options(headers: headers));
      print(response.data);
      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }

  Future<bool> uppdateCar(int carID, String color, String power,
      String releaseYear, String price) async {
    var body = {
      "color": "$color",
      "power": "$power",
      "price": "$price"
    };
    print(body);
    print(getCarsUrl + "/$carID");
    try {
      Response response = await _dio.put(getCarsUrl + "/$carID",
          data: body, options: Options(headers: headers));
      print(response.data);
      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
    // var client = http.Client();
    // var body = {
    //   'color': '$color',
    //   'power': '$power',
    //   'release_year': '$releaseYear',
    //   'price': '$price'
    // };
    // print(body);
    // print(getCarsUrl + "/$carID");
    // try {
    //   // Response response = await _dio.put(getCarsUrl + "/$carID",
    //   //     data: body, options: Options(headers: headers));
    //   var response = await client.put(getCarsUrl + "/$carID",
    //       body: body);
    //   print(response.body);
    //   client.close();
    //   return true;
    // } catch (error, stacktrace) {
    //   print("Exception occured: $error stackTrace: $stacktrace");
    //   client.close();
    //   return false;
    // }
  }
}
