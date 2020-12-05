import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/registers.dart';
import 'package:flutter_app/services/polling_service.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChargeControllerModel model = ChargeControllerModel();
    var pollingService = PollingService(model);
    pollingService.start();

    return (Scaffold(
        appBar: AppBar(title: Text('MidNite Classic')),
        body: ChangeNotifierProvider(
            create: (context) => model, child: DashboardWidget())));
  }
}

class DashboardWidget extends StatelessWidget {
  final ChargeControllerModel model = ChargeControllerModel();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: <Widget>[
          DialWidget("PV Current (A)", 40, () => model.pvAmps),
          DialWidget("PV Voltage (V)", 150, () => model.pvVolts),
          DialWidget("Batt Current (A)", 40, () => model.battAmps),
          DialWidget("Batt Voltage (V)", 60, () => model.battVolts),
          DialWidget("Power (W)", 60, () => model.power),
          //DialWidget("Energy (kWh)", 60, () => model.energy),
          DialWidget("WBJr Current (A)", 20, () => model.wbjrAmps)
        ]);
  }
}

typedef double Getter();

class DialWidget extends StatefulWidget {
  final String name;
  final double range;
  final Getter getter;

  DialWidget(this.name, this.range, this.getter);

  @override
  _DialWidgetState createState() => _DialWidgetState();
}

class _DialWidgetState extends State<DialWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.only(bottom: 30, top: 30),
        child: Consumer<ChargeControllerModel>(
            builder: (context, chargeController, child) =>
                Column(children: <Widget>[
                  Text(widget.name),
                  Expanded(
                      child: SfRadialGauge(axes: <RadialAxis>[
                    RadialAxis(
                        minimum: 0,
                        maximum: widget.range,
                        pointers: <GaugePointer>[
                          NeedlePointer(
                              value: widget.getter(),
                              //chargeController.getParameter(widget.parameterName),
                              lengthUnit: GaugeSizeUnit.factor,
                              needleLength: 0.6,
                              needleStartWidth: 1,
                              needleEndWidth: 3,
                              enableAnimation: true)
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                              widget: Container(
                                  child: Text(
                                      widget.getter().toStringAsFixed(1),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold))),
                              angle: 90,
                              positionFactor: 1)
                        ])
                  ]))
                ])));
  }
}
