import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/constants/scan_type_enum.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/widgets.dart';

import 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const CustomActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody();

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    final scanListProvider = Provider.of<ScanListProvider>(context,
        listen: false); //para que no se redibuje el widget aqui

    switch (currentIndex) {
      case 0:
        scanListProvider.getScansByType(ScanTypeEnum.geo);
        return const MapsHistoryScreen();
      case 1:
        scanListProvider.getScansByType(ScanTypeEnum.http);
        return const DirectionsScreen();

      default:
        return const MapsHistoryScreen();
    }
  }
}
