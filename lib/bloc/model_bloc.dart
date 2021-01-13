import 'package:kursach_avto_app/model/model_response.dart';
import 'package:kursach_avto_app/repo/app_repo.dart';
import 'package:rxdart/rxdart.dart';

class MarkBloc {
  final AppRepository _repository = AppRepository();
  final BehaviorSubject<ModelResponse> _subject =
      BehaviorSubject<ModelResponse>();

  getAllModels() async {
    ModelResponse response = await _repository.getAllModels();
    _subject.sink.add(response);
  }


  addModel(int brandId, String nameModel, String nameColor, String releaseYear) async{
    bool isResponse = await _repository.addModel(brandId,nameModel, nameColor, releaseYear);
    if(isResponse){
      ModelResponse response = await _repository.getAllModels();
      subject.sink.add(response);
    }
  }
  removeModel(int idModel) async{
    bool isResponse = await _repository.removeModel(idModel);
    if(isResponse){
      ModelResponse response = await _repository.getAllModels();
      subject.sink.add(response);
    }
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ModelResponse> get subject => _subject;
}

final modelsBloc = MarkBloc();
