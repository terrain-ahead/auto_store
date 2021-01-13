
import 'package:kursach_avto_app/model/mark_model.dart';


class MarkResponse {
  final List<MarkModel> marks;
  final String error;

  MarkResponse(this.marks, this.error);

  MarkResponse.fromJson(Map<String, dynamic> json)
      : marks =
            (json["brands_list"] as List).map((i) => new MarkModel.fromJson(i)).toList().reversed.toList(),
        error = "";

  MarkResponse.withError(String errorValue)
      : marks = List(),
        error = errorValue;
}