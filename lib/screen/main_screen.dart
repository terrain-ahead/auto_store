import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:kursach_avto_app/bloc/bottom_navbar_bloc.dart';
import 'package:kursach_avto_app/screen/search_screen.dart';
import 'package:kursach_avto_app/style/style.dart';

import 'adminScreen/add_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: bottomNavBarBloc.itemStream,
          initialData: bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.SEARCH:
                return SearchScreen();
              case NavBarItem.ADD:
                return AddScreen();
            }
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: bottomNavBarBloc.itemStream,
        initialData: bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[100], spreadRadius: 0, blurRadius: 2),
              ],
            ),
            child: ClipRRect(
              child: BottomNavigationBar(
                backgroundColor: Style.mainColor,
                iconSize: 20,
                unselectedItemColor: Style.grey,
                unselectedFontSize: 9.5,
                selectedFontSize: 9.5,
                type: BottomNavigationBarType.shifting,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                fixedColor: Style.titleColor,
                currentIndex: snapshot.data.index,
                onTap: bottomNavBarBloc.pickItem,
                items: [
                  BottomNavigationBarItem(
                    label: "",
                    icon: Icon(EvaIcons.searchOutline),
                    activeIcon: Icon(EvaIcons.search),
                  ),
                  BottomNavigationBarItem(
                    label: "",
                    icon: Icon(Icons.add_shopping_cart_outlined),
                    activeIcon: Icon(Icons.add_shopping_cart),
                  ),
            
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget testScrren() {
  return Center(
    child: Text("test"),
  );
}
