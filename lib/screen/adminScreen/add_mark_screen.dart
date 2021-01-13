import 'package:flutter/material.dart';
import 'package:kursach_avto_app/bloc/mark_bloc.dart';
import 'package:kursach_avto_app/bloc/model_bloc.dart';
import 'package:kursach_avto_app/elements/loader.dart';
import 'package:kursach_avto_app/model/mark_response.dart';
import 'package:kursach_avto_app/style/style.dart';

class AddMarkScreen extends StatefulWidget {
  @override
  _AddMarkScreenState createState() => _AddMarkScreenState();
}

class _AddMarkScreenState extends State<AddMarkScreen> {
  final _textMarkController = TextEditingController();
  final _textCityController = TextEditingController();
  @override
  void initState() {
    modelsBloc.getAllModels();
    marksBloc.getAllMarks();
    super.initState();
  }

  @override
  void dispose() {
    _textCityController.clear();
    _textMarkController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
        children: [
          Column(
              children: [
                _buildAddTextField(),
                _buildAddCityTextField(),
                _buildButtonSend(),
              ],
            ),
          
          _buildResultsList(),
        ],
      ),
    );
  }

  Widget _buildAddTextField() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextField(
              controller: _textMarkController,
              style: TextStyle(
                color: Style.standardTextColor,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14.0),
                hintText: 'Вводите название марки',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCityTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextField(
              controller: _textCityController,
              style: TextStyle(
                color: Style.standardTextColor,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14.0),
                hintText: 'Вводите страну',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSend() {
    return Padding(
      padding: EdgeInsets.only(right: 15),
      child: Container(
        width: 130,
        height: 40,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () {
            _textMarkController.text.isNotEmpty &&
                    _textCityController.text.isNotEmpty
                ? marksBloc.addMark(
                    _textMarkController.text, _textCityController.text)
                // ignore: unnecessary_statements
                : null;
            _textMarkController.clear();
            _textCityController.clear();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: Style.titleColor,
          child: Text(
            'Отправить',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsList() {
    return Container(
      height: 200,
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: StreamBuilder(
        stream: marksBloc.subject,
        // ignore: missing_return
        builder: (context, AsyncSnapshot<MarkResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null &&
                snapshot.data.error.length > 0) {
              return Container();
            }
            return ListView.builder(
                itemCount: snapshot.data.marks.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Text(snapshot.data.marks[index].name)),
                      Expanded(
                          child: Text(
                        snapshot.data.marks[index].manufacturerCountry != null
                            ? snapshot.data.marks[index].manufacturerCountry
                            : "",
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            marksBloc
                                .removeMark(snapshot.data.marks[index].id);
                          },
                          child: Text(
                            "Удалить",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      )
                    ],
                  ));
                });
          } else {
            return buildLoadingWidget();
          }
        }),
        ),
    );
  }
}
