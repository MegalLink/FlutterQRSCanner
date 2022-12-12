import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/preferences/preferences.dart';
import 'package:qr_reader/providers/theme_provider.dart';
import 'package:qr_reader/widgets/side_menu.dart';

class SettingsScreen extends StatefulWidget {
  static const routerScreenName = "settings";
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isPersonalizedColor = false;

  @override
  Widget build(BuildContext context) {
    final showedWidget = isPersonalizedColor
        ? const _PersonalizedColor()
        : const _SystemColors();

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      drawer: const SideMenu(),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.w300),
          ),
          const Divider(),
          SwitchListTile.adaptive(
              value: Preferences.isDarkMode,
              title: const Text('Dark mode'),
              onChanged: ((bool value) {
                setState(() {
                  Preferences.isDarkMode = value;
                  themeProvider.setThemeMode(value);
                });
              })),
          const Divider(),
          SwitchListTile.adaptive(
              value: isPersonalizedColor,
              title: const Text('Set hexadecimal color'),
              onChanged: ((bool value) {
                setState(() {
                  isPersonalizedColor = value;
                });
              })),
          const Divider(),
          showedWidget
        ],
      )),
    );
  }
}

class _SystemColors extends StatefulWidget {
  const _SystemColors();

  @override
  State<_SystemColors> createState() => _SystemColorsState();
}

class _SystemColorsState extends State<_SystemColors> {
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          RadioListTile(
              value: 0,
              groupValue: selectedColor,
              title: const Text('Deep Purple'),
              onChanged: (value) {
                const color = Colors.deepPurple;
                theme.setThemeColor(color);
                Preferences.color = _convertColorToHexString(color);
                setState(() {
                  selectedColor = value ?? 0;
                });
              }),
          RadioListTile(
              value: 1,
              groupValue: selectedColor,
              title: const Text('Red Accent'),
              onChanged: (value) {
                const color = Colors.red;
                theme.setThemeColor(color);
                Preferences.color = _convertColorToHexString(color);
                setState(() {
                  selectedColor = value ?? 1;
                });
              }),
        ],
      ),
    );
  }

  String _convertColorToHexString(MaterialColor color) {
    return "#${color.value.toRadixString(16).substring(2)}";
  }
}

class _PersonalizedColor extends StatelessWidget {
  const _PersonalizedColor();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        maxLength: 7,
        initialValue: '#',
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          if (_isValidHexColor(value)) {
            theme.setHexThemeColor(value);
            Preferences.color = value;
          }
        },
        validator: (value) {
          if (!_isValidHexColor(value)) {
            return 'Ingrese un color headecimal valido #ff0000';
          }

          return null;
        },
        decoration: const InputDecoration(
            labelText: 'Color', helperText: 'Color en hexadecimal: #ff0000 '),
      ),
    );
  }

  bool _isValidHexColor(String? value) {
    String pattern = r'^#([a-f0-9]{6})$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(value ?? '');
  }
}
