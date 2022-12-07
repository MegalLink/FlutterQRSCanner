import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';

class MapsHistoryScreen extends StatelessWidget {
  const MapsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context,
        listen: true); // necesito que se redibuje cuando cambie en este widget
    final scans = scanListProvider.scans;
    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: ((context, index) => ListTile(
              leading: Icon(
                Icons.map,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(scans[index].value),
              subtitle: Text('${scans[index].id}'),
              trailing:
                  const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () => print("open something tap"),
            )));
  }
}
