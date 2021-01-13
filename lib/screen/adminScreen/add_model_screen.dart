import 'package:flutter/material.dart';
import 'package:kursach_avto_app/bloc/mark_bloc.dart';

import 'package:kursach_avto_app/bloc/model_bloc.dart';
import 'package:kursach_avto_app/elements/loader.dart';
import 'package:kursach_avto_app/model/mark_model.dart';
import 'package:kursach_avto_app/model/mark_response.dart';
import 'package:kursach_avto_app/model/model_response.dart';
import 'package:kursach_avto_app/style/style.dart';

class AddModelScreen extends StatefulWidget {
  @override
  _AddModelScreenState createState() => _AddModelScreenState();
}

class _AddModelScreenState extends State<AddModelScreen> {
  final _textModelController = TextEditingController();
  final _textColorController = TextEditingController();
  final _textYearController = TextEditingController();

  MarkModel currMark;

  @override
  initState() {
    modelsBloc.getAllModels();
    marksBloc.getAllMarks();
    super.initState();
  }

  
  @override
  void dispose() {
    _textColorController.clear();
    _textYearController.clear();
    _textModelController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
  
    return Center(
      child: SingleChildScrollView(
              child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  _buildChoiceMark(),
                  _buildAddTextField(),
                  _buildAddColorTextField(),
                  _buildAddYearTextField(),
                  _buildButtonSend(),
                ],
                
              ),
            ),
            SizedBox(
              height: 1,
              child: Container(
                color: Style.titleColor,
              ),
            ),
            Container(height: 160, child: _buildResultsList()),
            
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceMark() {
    return StreamBuilder(
        stream: marksBloc.subject,
        // ignore: missing_return
        builder: (context, AsyncSnapshot<MarkResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return Container();
            }
            
            return DropdownButton<MarkModel>(
              hint: Text("Марка"),
              value: currMark,
              items: snapshot.data.marks.map((MarkModel value) {
                return new DropdownMenuItem<MarkModel>(
                  value: value,
                  child: new Text(value.name),
                );
              }).toList(),
              
              onChanged: (value) {
                setState(() {
                  currMark = value;
                });
              },
            );
          } else {
            return buildLoadingWidget();
          }
        });
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
              controller: _textModelController,
              style: TextStyle(
                color: Style.standardTextColor,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14.0),
                hintText: 'Вводите название модели',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddColorTextField() {
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
              controller: _textColorController,
              style: TextStyle(
                color: Style.standardTextColor,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14.0),
                hintText: 'Вводите цвет',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddYearTextField() {
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
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              controller: _textYearController,
              style: TextStyle(
                color: Style.standardTextColor,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14.0),
                hintText: 'Вводите год',
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
            _textModelController.text.isNotEmpty &&
                    _textColorController.text.isNotEmpty&&currMark!=null
                ? modelsBloc.addModel(currMark.id,
                    _textModelController.text, _textColorController.text,_textYearController.text)
                // ignore: unnecessary_statements
                : null;
            _textModelController.clear();
            _textColorController.clear();
            _textYearController.clear();
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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: StreamBuilder(
          stream: modelsBloc.subject,
          // ignore: missing_return
          builder: (context, AsyncSnapshot<ModelResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return Container();
              }
              return ListView.builder(
                  itemCount: snapshot.data.models.length,
                  itemBuilder: (context, index) {
                    return Container(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Text(snapshot.data.models[index].brandName)),
                        Expanded(
                            child: Text(
                          snapshot.data.models[index].name != null
                              ? snapshot.data.models[index].name
                              : "",
                          textAlign: TextAlign.center,
                        )),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              modelsBloc
                                  .removeModel(snapshot.data.models[index].id);
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
    );
  }
}
