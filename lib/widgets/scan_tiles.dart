import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';
import '../providers/scan_list_provider.dart';

class ScanTiles extends StatelessWidget {
  final IconData icon;
  const ScanTiles({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context,
        listen: true); // necesito que se redibuje cuando cambie en este widget
    final scans = scanListProvider.scans;
    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: ((context, index) => Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (direction) {
                scanListProvider.deleteScanByID(scans[index].id!);
              },
              child: ListTile(
                leading: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(scans[index].value),
                subtitle: Text('${scans[index].id}'),
                trailing:
                    const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                onTap: () => launchURL(context, scans[index]),
              ),
            )));
  }
}
