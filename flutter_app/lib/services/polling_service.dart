import 'dart:async';
import 'dart:math';

import 'package:flutter_app/models/registers.dart';
import 'package:ping_discover_network/ping_discover_network.dart';

class PollingService {

  ChargeControllerModel model;
  PollingService(this.model);

  void start() {
    const interval = const Duration(seconds: 3);
    print("In start");
    const port = 502;
    final stream = NetworkAnalyzer.discover2(
      '192.168.10',
      port,
      timeout: Duration(milliseconds: 5000),
    );

    int found = 0;
    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        found++;
        print('Found device: ${addr.ip}:$port');
      }
    }).onDone(() => print('Finish. Found $found device(s)'));
    new Timer.periodic(interval, poll);
  }

  void poll(Timer timer) {
    var val = Random().nextDouble()*40;
    model.pvAmps = val;
    model.notify();
  }
}