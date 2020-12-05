import 'package:flutter/cupertino.dart';

class ChargeControllerModel with ChangeNotifier {

  double pvAmps = 0;
  double pvVolts = 0;
  double battAmps = 0;
  double battVolts = 0;
  double power = 0;
  double energy = 0;
  double wbjrAmps = 0;
  String status = "Unknown";
  
  static final ChargeControllerModel _instance = ChargeControllerModel._internal();
  ChargeControllerModel._internal();

  factory ChargeControllerModel() {
    return _instance;
  }

  void notify() {notifyListeners();}
}
