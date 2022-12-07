import 'package:flutter/cupertino.dart';
import 'package:qr_reader/constants/scan_type_enum.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  Future<ScanModel> newScan(String scanValue) async {
    final newScan = ScanModel(value: scanValue);
    final id = await DBProvider.db.insertNewScan(newScan);
    newScan.id = id;
    ScanTypeEnum scanType =
        ScanTypeEnum.values.firstWhere((e) => e.value == newScan.type);
    getScansByType(scanType);
    return newScan;
  }

  getAllScans() async {
    final dbScans = await DBProvider.db.getAllScans();
    scans = [...dbScans];
    notifyListeners();
  }

  getScansByType(ScanTypeEnum type) async {
    final dbScans = await DBProvider.db.getScansByType(type.value);

    scans = [...dbScans];
    notifyListeners();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  deleteScanByID(int id) async {
    await DBProvider.db.deleteScan(id);
  }
}
