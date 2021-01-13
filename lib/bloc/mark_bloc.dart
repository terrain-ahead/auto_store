import 'package:kursach_avto_app/model/mark_response.dart';
import 'package:kursach_avto_app/repo/app_repo.dart';
import 'package:rxdart/rxdart.dart';

class MarkBloc {
  final AppRepository _repository = AppRepository();
  final BehaviorSubject<MarkResponse> _subject =
      BehaviorSubject<MarkResponse>();

  getAllMarks() async {
    MarkResponse response = await _repository.getAllMarks();
    _subject.sink.add(response);
  }

  addMark(String nameMark,String nameCity) async{
    bool isResponse = await _repository.addMark(nameMark, nameCity);
    if(isResponse){
      MarkResponse response = await _repository.getAllMarks();
      subject.sink.add(response);
    }
  }
  removeMark(int idMark) async{
    bool isResponse = await _repository.removeMark(idMark);
    if(isResponse){
      MarkResponse response = await _repository.getAllMarks();
      subject.sink.add(response);
    }
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MarkResponse> get subject => _subject;
}

final marksBloc = MarkBloc();
