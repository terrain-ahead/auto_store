


import 'dart:async';

enum LoginStateItem{LOGIN,APP,ERROR}


class LoginStateBloc{
  StreamController<LoginStateItem> _controller = StreamController<LoginStateItem>.broadcast();

  LoginStateItem defaultItem = LoginStateItem.LOGIN;

  pickItem(int i){
    switch(i){
      case 0:
        _controller.sink.add(LoginStateItem.LOGIN);
        break;
      case 1:
        _controller.sink.add(LoginStateItem.APP);
        break;
      case 2:
        _controller.sink.add(LoginStateItem.ERROR);
        break;
    }
  }

  Stream<LoginStateItem> get itemController => _controller.stream;

  dispose(){
    _controller?.close();
  }
}

final getLoginStateBloc = LoginStateBloc();