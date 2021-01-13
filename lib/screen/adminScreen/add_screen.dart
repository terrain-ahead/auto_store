import 'package:flutter/material.dart';
import 'package:kursach_avto_app/bloc/add_type_bloc.dart';
import 'package:kursach_avto_app/screen/adminScreen/add_car_screen.dart';
import 'package:kursach_avto_app/screen/adminScreen/add_mark_screen.dart';
import 'package:kursach_avto_app/screen/adminScreen/add_model_screen.dart';
import 'package:kursach_avto_app/style/style.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Добавить",
          style: kAppBarEnableTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Style.mainColor,
      ),
          body: SafeArea(
            child: Column(
              children: [
            _buildAddTypeCheck(),
            Expanded(
              child: StreamBuilder(
                stream: addTypeBloc.addTypeStream,
                initialData: addTypeBloc.defAddType,
                // ignore: missing_return
                builder: (context, AsyncSnapshot<AddTypeItem> snapshot) {
                  switch (snapshot.data) {
                    case AddTypeItem.MARK:
                      return AddMarkScreen();
                    case AddTypeItem.MODEL:
                      return AddModelScreen();
                    case AddTypeItem.CAR:
                      return AddCarScreen();
                  // ignore: empty_statements
                  };
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAddTypeCheck() {
    return StreamBuilder(
        stream: addTypeBloc.addTypeStream,
        initialData: addTypeBloc.defAddType,
        builder: (context, AsyncSnapshot<AddTypeItem> snapshot) {
          return Container(
            height: 60,
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    addTypeBloc.pickWeek(0);
                  },
                  child: Container(
                    color: Style.mainColor,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Марку",
                        style: snapshot.data == AddTypeItem.MARK
                            ? kAppBarEnableTextStyle
                            : kAppBarDisableTextStyle,
                      ),
                    ),
                  ),
                )),
                SizedBox(
                  height: 25,
                  width: 1,
                  child: Container(
                    color: Style.titleColor,
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    addTypeBloc.pickWeek(1);
                  },
                  child: Container(
                    color: Style.mainColor,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Модель",
                        style: snapshot.data == AddTypeItem.MODEL
                            ? kAppBarEnableTextStyle
                            : kAppBarDisableTextStyle,
                      ),
                    ),
                  ),
                )),
                SizedBox(
                  height: 25,
                  width: 1,
                  child: Container(
                    color: Style.titleColor,
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    addTypeBloc.pickWeek(2);
                  },
                  child: Container(
                    color: Style.mainColor,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Машину",
                        style: snapshot.data == AddTypeItem.CAR
                            ? kAppBarEnableTextStyle
                            : kAppBarDisableTextStyle,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          );
        });
  }
}


