

import 'dart:async';

enum NavBarItem{SEARCH,ADD}

class BottomNavBarBloc{

  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.SEARCH;
  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.SEARCH);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.ADD);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}
final bottomNavBarBloc = BottomNavBarBloc();