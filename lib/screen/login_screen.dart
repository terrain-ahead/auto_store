import 'package:flutter/material.dart';
import 'package:kursach_avto_app/bloc/login_state_bloc.dart';
import 'package:kursach_avto_app/screen/main_screen.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: getLoginStateBloc.itemController,
          initialData: getLoginStateBloc.defaultItem,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<LoginStateItem> snapshot) {
            switch(snapshot.data){
              case LoginStateItem.APP:
                return MainScreen();
              case LoginStateItem.LOGIN:
                return SafeArea(
                  child: Center(
                    child: FlatButton(
                        child: Text(
                            "goLogin"
                        ),
                      onPressed: (){
                          getLoginStateBloc.pickItem(1);
                      },
                    ),
                  ),
                );
              case LoginStateItem.ERROR:
                return Center(
                  child: Text(
                      "ERROR"
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
