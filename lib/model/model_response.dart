
import 'package:kursach_avto_app/model/model_model.dart';



class ModelResponse {
  final List<ModelModel> models;
  final String error;

  ModelResponse(this.models, this.error);

  ModelResponse.fromJson(Map<String, dynamic> json)
      : models =
            (json["models_list"] as List).map((i) => new ModelModel.fromJson(i)).toList().reversed.toList(),
        error = "";

  ModelResponse.withError(String errorValue)
      : models = List(),
        error = errorValue;
}