

import 'dart:async';

enum AddTypeItem{MARK,MODEL,CAR}

class AddTypeBloc{
  final StreamController<AddTypeItem> _addTypeController =
  StreamController<AddTypeItem>.broadcast();

  AddTypeItem defAddType = AddTypeItem.MARK;

  Stream<AddTypeItem> get addTypeStream => _addTypeController.stream;

  void pickWeek(int i) {
    switch (i) {
      case 0:
        _addTypeController.sink.add(AddTypeItem.MARK);
        break;
      case 1:
        _addTypeController.sink.add(AddTypeItem.MODEL);
        break;
      case 2:
        _addTypeController.sink.add(AddTypeItem.CAR);
        break;
    }
  }

    void setCurrWeek(AddTypeItem weekItem){
      this.defAddType = weekItem;
    }
    close() {
      _addTypeController?.close();
    }
  }
  final addTypeBloc = AddTypeBloc();
