import 'package:flutter/material.dart';

class Style {

  const Style();

  static const Color mainColor = const Color(0xFFFFFFFF);
  static const Color secondColor = const Color(0xFFedf5da);
  static const Color grey = const Color(0xFFc2c2c2);
  static const Color background = const Color(0xFFf0f1f6);
  static const Color titleColor = const Color(0xFF02ba44);
  static const Color standardTextColor = const Color(0xFF232d0a);
  static const primaryGradient = const LinearGradient(
    colors: const [ Color(0xFF111428), Color(0xFF29304a)],
    stops: const [0.0, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

final kListItemBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(25.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kHintTextStyle = TextStyle(
  color: Color(0xFFc5c8cf),
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Style.titleColor,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kAppBarBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kAppBarDisableTextStyle = TextStyle(
  color: Style.standardTextColor,
  fontWeight: FontWeight.normal,
  fontSize: 15,
  fontFamily: 'OpenSans',

);
final kAppBarEnableTextStyle = TextStyle(
  color: Style.titleColor,
  fontWeight: FontWeight.normal,
  fontSize: 15,
  fontFamily: 'OpenSans',
);

