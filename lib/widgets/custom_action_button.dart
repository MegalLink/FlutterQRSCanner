import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancelar', false, ScanMode.QR);

        if (barcodeScanRes == "-1") {
          return;
        }

        final newScan = await scanListProvider.newScan(barcodeScanRes);
        // ignore: use_build_context_synchronously
        launchURL(context, newScan);
      },
    );
  }
}
