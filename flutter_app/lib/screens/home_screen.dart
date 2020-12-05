import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/configuration.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ConfigurationModel model = ConfigurationModel();

    return (Scaffold(
        appBar: AppBar(title: Text('MidNite Classic')),
        body: ChangeNotifierProvider(
            create: (context) => model, child: HomeScreenWidget())));
  }
}

class HomeScreenWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}