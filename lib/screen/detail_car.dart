import 'package:flutter/material.dart';
import 'package:kursach_avto_app/bloc/car_bloc.dart';
import 'package:kursach_avto_app/model/car_model.dart';
import 'package:kursach_avto_app/style/style.dart';

class DetailCar extends StatefulWidget {
  final CarModel carModel;
  const DetailCar({Key key, this.carModel}) : super(key: key);

  @override
  _DetailCarState createState() => _DetailCarState();
}

class _DetailCarState extends State<DetailCar> {
  CarModel _carModel;
  final _textPriceController = TextEditingController();
  final _textPowerController = TextEditingController();
  final _textColorController = TextEditingController();
  final _textYearController = TextEditingController();

  @override
  void initState() {
    _carModel = widget.carModel;
    _textPriceController.text = _carModel.price.toString();
    _textPowerController.text = _carModel.power.toString();
    _textColorController.text = _carModel.color;
    _textYearController.text = _carModel.releaseYear;
    super.initState();
  }

  @override
  void dispose() {
    _textPriceController.clear();
    _textPowerController.clear();
    _textColorController.clear();
    _textYearController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _buildAddReport(),
    );
  }

  Widget _buildCarPhoto() {
    return Image.memory(
      _carModel.photo,
      fit: BoxFit.fitWidth,
    );
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

  Widget _buildSendReportBtn() {
    return Container(
      padding: EdgeInsets.all(30.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          await carsBloc.uppdateCar(
              _carModel.id,
              _textColorController.text,
              _textPowerController.text,
              _textYearController.text,
              _textPriceController.text);

          if (carsBloc.subject.stream.value.error == "Успешно") {
            _textPriceController.clear();
            _textPowerController.clear();
            _textColorController.clear();
            _textYearController.clear();
            carsBloc.getAllCars();
            Navigator.pop(context);
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

  Widget _buildAddReport() {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildCarPhoto(),
                _buildColorTextField(),
                _buildPowerTextField(),
             
                _buildPriceTextField(),
                _buildSendReportBtn()
              ]),
        )
      ],
    );
  }
}
