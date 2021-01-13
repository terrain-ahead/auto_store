import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kursach_avto_app/bloc/model_bloc.dart';
import 'package:kursach_avto_app/bloc/car_bloc.dart';
import 'package:kursach_avto_app/elements/loader.dart';
import 'package:kursach_avto_app/model/model_model.dart';
import 'package:kursach_avto_app/model/model_response.dart';

import 'package:kursach_avto_app/style/style.dart';

class AddCarScreen extends StatefulWidget {
  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  File _selectedFile;
  bool _inProcess = false;

  final _textPriceController = TextEditingController();
  final _textPowerController = TextEditingController();
  final _textColorController = TextEditingController();
  final _textYearController = TextEditingController();
  ModelModel currMark;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textPriceController.clear();
    _textPowerController.clear();
    _textColorController.clear();
    _textYearController.clear();
    _selectedFile = null;
    super.dispose();
  }

  Widget _buildSetPhotoLabel() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text("Добавьте фото", style: kLabelStyle),
    );
  }

  Widget _buildSendReportBtn() {
    return Container(
      padding: EdgeInsets.all(30.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          await carsBloc.addCar(currMark.id,_selectedFile,_textColorController.text,_textPowerController.text,_textYearController.text,_textPriceController.text);

          if (carsBloc.subject.stream.value.error ==
              "Успешно") {
            setState(() {
              _selectedFile = null;
            });
            _textPriceController.clear();
            _textPowerController.clear();
            _textColorController.clear();
            _textYearController.clear();
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Style.titleColor,
        child: Text(
          'Отправить',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Image.file(
          _selectedFile,
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return SizedBox();
    }
  }

  getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Style.mainColor,
            toolbarTitle: "Обрезать",
            statusBarColor: Style.titleColor,
            backgroundColor: Colors.white,
            toolbarWidgetColor: Style.titleColor,
            activeControlsWidgetColor: Style.titleColor,
          ));

      this.setState(() {
        _selectedFile = cropped;
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _buildAddReport(),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceModel() {
    return StreamBuilder(
        stream: modelsBloc.subject,
        // ignore: missing_return
        builder: (context, AsyncSnapshot<ModelResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return Container();
            }

            return DropdownButton<ModelModel>(
              hint: Text("Модель"),
              value: currMark,
              items: snapshot.data.models.map((ModelModel value) {
                return new DropdownMenuItem<ModelModel>(
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

  Widget _buildColorTextField() {
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
              controller: _textColorController,
              style: TextStyle(
                color: Style.standardTextColor,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14.0),
                hintText: 'Введите цвет',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPowerTextField() {
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
              controller: _textPowerController,
              style: TextStyle(
                color: Style.standardTextColor,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14.0),
                hintText: 'Введите мощность',
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
                hintText: 'Введите год',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceTextField() {
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
              controller: _textPriceController,
              style: TextStyle(
                color: Style.standardTextColor,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14.0),
                hintText: 'Введите цены',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddReport() {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildChoiceModel(),
              _buildColorTextField(),
              _buildPowerTextField(),
              _buildAddYearTextField(),
              _buildPriceTextField(),
              _buildSetPhotoLabel(),
              getImageWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                      elevation: 5,
                      minWidth: 150,
                      color: Style.titleColor,
                      child: Text(
                        "Камера",
                        style: TextStyle(color: Style.mainColor),
                      ),
                      onPressed: () {
                        getImage(ImageSource.camera);
                      }),
                  MaterialButton(
                      elevation: 5,
                      minWidth: 150,
                      color: Style.mainColor,
                      child: Text(
                        "Из устройства",
                        style: TextStyle(color: Style.titleColor),
                      ),
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      })
                ],
              ),
              _buildSendReportBtn(),
            ],
          ),
        ),
        (_inProcess)
            ? Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.95,
                child: Center(
                  child: buildLoadingWidget(),
                ),
              )
            : Center(),
      ],
    );
  }
}
