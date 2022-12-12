import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/preferences/preferences.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/theme_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UIProvider()),
    ChangeNotifierProvider(create: (_) => ScanListProvider()),
    ChangeNotifierProvider(
        create: (_) => ThemeProvider(
            isDarkMode: Preferences.isDarkMode, hexColor: Preferences.color))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'QR reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: theme.color,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: theme.color,
      ),
      themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: HomeScreen.routerScreenName,
      routes: {
        HomeScreen.routerScreenName: (_) => const HomeScreen(),
        MapScreen.routerScreenName: (_) => const MapScreen(),
        SettingsScreen.routerScreenName: (_) => const SettingsScreen(),
      },
    );
  }
}
