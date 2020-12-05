import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/registers.dart';
import 'package:provider/provider.dart';

class ConfigurationModel with ChangeNotifier {

  String deviceIP;
  String message;

  static final ConfigurationModel _instance = ConfigurationModel._internal();
  ConfigurationModel._internal();

  factory ConfigurationModel() {
    return _instance;
  }

  void notify() {notifyListeners();}
}