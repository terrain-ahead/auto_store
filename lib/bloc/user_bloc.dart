
import 'package:kursach_avto_app/model/user_response.dart';
import 'package:kursach_avto_app/repo/app_repo.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final AppRepository _repository = AppRepository();
  final BehaviorSubject<UserResponse> _subject =
      BehaviorSubject<UserResponse>();

  getAllUser() async {
    UserResponse response = await _repository.getAllUser();
    _subject.sink.add(response);
  }


  dispose() {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;
}

final usersBloc = UserBloc();
