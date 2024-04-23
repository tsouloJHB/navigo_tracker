import 'package:flutter/foundation.dart';
import 'package:navigo_tracker/models/BusInfo.dart';

class BusInfoState with ChangeNotifier {
  late BusInfo _busInfo;
  BusInfo get getBusInfo => _busInfo;

  void setBusInfo(BusInfo busInfo) {
    _busInfo = busInfo;
    notifyListeners();
  }
}
